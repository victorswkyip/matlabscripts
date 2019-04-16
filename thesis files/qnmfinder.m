clear;

%% DEFINITIONS
model_file_name = 'nanorod.mph';
tested_field_comp = 'Ez';


%% PARAMETERS
delta = 0.001;
num_qnm_iter = 10;
eval_point = [0;0;-80];
omega_start = 2.0414e+15 + 1.1094e+14i;


%% INITIALIZE
import com.comsol.model.*
import com.comsol.model.util.*
ModelUtil.showProgress(true);

omega_set = omega_start;
tested_field_set = 0;
omega = omega_start;
pole_estimate = omega_start;


%% POLE-SEARCH LOOP
for iter=1:num_qnm_iter
    tic;
    fprintf('Iteration %d ...\n ',iter);
    %% Load COMSOL model and prepare
    model = mphload(model_file_name);
    model.result.numerical.create('global_eval_QNM', 'Global');
    model.param.set('omega',num2str(omega,'%12.15e'));
    
    % run
    fprintf('\t COMSOL field calculations on pole frequency estimate\n');
    model.study('std1').run();

    
    % get the field on the evaluation point
    [temp]=mphinterp(model,{['emw.' tested_field_comp]},'coord',eval_point,'Complexout','on');
    tested_field_tot(iter)=temp;
    clear temp

    fprintf(strcat('\t Iteration time in minutes:\t', num2str(toc/60), '\n'));
    
    
    %% Compute new set of (3) interpolating frequencies
    tested_field_set(end)=tested_field_tot(iter);
    [omega_set,tested_field_set]=get_omegas(omega_set,tested_field_set,delta);
    omega=omega_set(end);
    pole_estimate(iter+1)=omega;
        
      
    %% SAVE DATA
    save('pole.mat','-regexp','^(?!(model|ans|h1)$).');
end
