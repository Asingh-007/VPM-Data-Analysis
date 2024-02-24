function export_results(aoa_vector, x_control, pressure_coefficient, CL, CL_k, CD, CM, plot_title)

    aoa_vector_transpose = transpose(aoa_vector);

    pressure_file_path = 'Output\' + plot_title +'_Pressure_Coefficent_Data.xlsx';
   
    pressure_coefficient_transpose = transpose(pressure_coefficient);

    writematrix('X Coordinate' , pressure_file_path,  'Sheet',1,'Range','B1');
    writematrix('Angle of Attack [°]' , pressure_file_path,  'Sheet',1,'Range','A4');
    writematrix('Pressure Coefficent(s)' , pressure_file_path,  'Sheet',1,'Range','B4');

    writematrix(x_control, pressure_file_path,  'Sheet',1,'Range','B2');
    writematrix(aoa_vector_transpose , pressure_file_path,  'Sheet',1,'Range','A5');
    writecell(pressure_coefficient_transpose , pressure_file_path,  'Sheet',1,'Range','B5');

    ldm_file_path = 'Output\' + plot_title +'_LDM_Coefficent_Data.xlsx';
   
    CL_transpose = transpose(CL);
    CL_k_transpose = transpose(CL_k);
    CD_transpose = transpose(CD);
    CM_transpose = transpose(CM);

    writematrix('Angle of Attack [°]' , ldm_file_path,  'Sheet',1,'Range','A1');
    writematrix('Pressure Distribution Lift Coefficent(s)' , ldm_file_path,  'Sheet',1,'Range','B1');
    writematrix('Kuta Joukovsky Lift Coefficent(s)' , ldm_file_path,  'Sheet',1,'Range','C1');
    writematrix('Drag Coefficent(s)' , ldm_file_path,  'Sheet',1,'Range','D1');
    writematrix('Moment Coefficent(s)' , ldm_file_path,  'Sheet',1,'Range','E1');

    writematrix(aoa_vector_transpose , ldm_file_path,  'Sheet',1,'Range','A2');
    writematrix(CL_transpose, ldm_file_path,  'Sheet',1,'Range','B2');
    writematrix(CL_k_transpose, ldm_file_path,  'Sheet',1,'Range','C2');
    writematrix(CD_transpose, ldm_file_path,  'Sheet',1,'Range','D2');
    writematrix(CM_transpose, ldm_file_path,  'Sheet',1,'Range','E2');