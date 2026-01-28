% Upload CSV files from a PTC run to the Penguin database table 'PTC'
% Ben Werb, bwerb@mbari.org, 1/27/2026

% Connect to database and change catelogue to PENGUIN
conn = connect_penguin();

% Fetch unique filenames
sqlquery = 'SELECT DISTINCT filename FROM PTC ORDER BY filename;';
uniqueFilenames = fetch(conn, sqlquery);%% Get all files in directory that are not already in the database

% Get new files to be uploaded
dirPath = '\\sirocco\wwwroot\lobo\Data\PTCData';
ptcFiles = dir(dirPath);
fnames = cell2table({ptcFiles.name}',"VariableNames",{'names'});
ptcFiles = ptcFiles(~[ptcFiles.isdir] &...
    ~ismember(fnames.names',uniqueFilenames.filename));
% Process files into structured table matching database format
n = length(ptcFiles(:));
for i = 1:n
    folder = ptcFiles(i).folder;
    name = ptcFiles(i).name;
    filename = fullfile(folder,name);
    PTC = read_ptc_csv(filename); % Function ensures table reads correctly
    % LabviewDateTime format: '1/16/2026 2:22:20 PM'
    PTC.LabviewDateTime = datetime(PTC.LabviewDateTime, ...
        'InputFormat', 'M/d/yyyy h:mm:ss a', ...
        'Format', 'yyyy-MM-dd HH:mm:ss');
    
    % DateTime format: '01/16/2026 22:18:35'
    PTC.DateTime = datetime(PTC.DateTime, ...
        'InputFormat', 'MM/dd/yyyy HH:mm:ss', ...
        'Format', 'yyyy-MM-dd HH:mm:ss');
    
    PTC.filename = repmat(string(name),height(PTC),1); % Add filename col
    sqlwrite(conn, 'PTC', PTC); % Push to database
end
%
% Close connection
close(conn);