function export_model(model, filepath)


coeffs = coeffvalues(model);
model_formula = formula(model);

writematrix(coeffs, filepath);
writematrix(model_formula, filepath, 'Sheet',1,'Range','A2:A2'); % Write Formula underneath Coefficients
