function[x_upper, y_upper, x_lower, y_lower, plot_title] = extract_excel_data(file_path)

opts = spreadsheetImportOptions("NumVariables", 4); % Extracting Data from Spreadsheet
    
    opts.Sheet = "Sheet1";
   
    
    opts.VariableNames = ["xu", "yu", "xl", "yl"];
    opts.VariableTypes = ["double", "double", "double", "double"];
    opts.DataRange = ['A2'];
    
    airfoil = readtable(file_path, opts, "UseExcel", false);
    
    x_upper = airfoil.xu;
    y_upper = airfoil.yu;
    x_lower = airfoil.xl;
    y_lower = airfoil.yl;

    [~,filename] = fileparts(file_path);

    plot_title = filename;