function export_airfoil(x_upper, y_upper, x_lower, y_lower, plot_title)


filepath = strcat('Output\', plot_title,'.xlsx');



writematrix('X Upper', filepath, 'Sheet',1,'Range','A1');
writematrix('Y Upper', filepath, 'Sheet',1,'Range','B1');
writematrix('X Lower', filepath, 'Sheet',1,'Range','C1');
writematrix('Y Lower', filepath, 'Sheet',1,'Range','D1');

writematrix(x_upper, filepath, 'Sheet',1,'Range','A2');
writematrix(y_upper, filepath, 'Sheet',1,'Range','B2');
writematrix(x_lower, filepath, 'Sheet',1,'Range','C2');
writematrix(y_lower, filepath, 'Sheet',1,'Range','D2');