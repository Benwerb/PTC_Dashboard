function conn = connect_penguin(username, password)
    % Connect to database
    if nargin < 2
        username = '';
        password = '';
    end
    
    try
        conn = database('Penguin', username, password);
        
        if ~isopen(conn)
            error('Database:ConnectionFailed', ...
                  'Connection failed: %s', conn.Message);
        end
        
        % Switch to PENGUIN database
        execute(conn, 'USE PENGUIN;');
        
        disp('Successfully connected to PostgreSQL database');
        
    catch ME
        fprintf(2, 'Error: %s\n', ME.message);
        fprintf(2, 'Database connection failed. Check ODBC settings.\n');
        rethrow(ME);  % Rethrow to prevent silent failures
    end
end