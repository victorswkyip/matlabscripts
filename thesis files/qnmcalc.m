clear; close;

%% DEFINITIONS
model_file_name = 'nanorod.mph';
save_file =  'qnm';
dipole_name = 'epd1';


%% PARAMETERS

% Visualisation plane
xp = 0;
yp = -500:1:500;
zp = -500:1:500;
[Xp,Yp,Zp] = meshgrid(xp,yp,zp);
XYZ = [Xp(:),Yp(:),Zp(:)];

sym_factor = 4;
omega_pole = 2.045744014751479e+15 + 1.044872469903720e+14i;
omega = omega_pole * (1-1.e-5);
delta_pole = omega_pole - omega;


%% Initializing
import com.comsol.model.*
import com.comsol.model.util.*
ModelUtil.showProgress(true);

tic;

%% Run the COMSOL simulation at 'omega' to get the total field
fprintf('\t Total field calculations on pole frequency\n');

% set
model = mphload(model_file_name);
model.param.set('omega',num2str(omega,'%12.15e'));
model.result.numerical.create('global_eval_QNM', 'Global');

% run
model.study('std1').run();


% retrieve electric point dipole position and dipole
if strcmp( model.physics('emw').feature(dipole_name).getString('DipoleSpecification'),'DipoleMoment')
    dip_mom_str = model.physics('emw').feature(dipole_name).getStringArray('pI');
    model.result.numerical('global_eval_QNM').set('expr',dip_mom_str(3));% Jz
    dipole_mom(3) = model.result.numerical('global_eval_QNM').getReal();
    model.result.numerical('global_eval_QNM').set('expr',dip_mom_str(2));% Jy
    dipole_mom(2) = model.result.numerical('global_eval_QNM').getReal();
    model.result.numerical('global_eval_QNM').set('expr',dip_mom_str(1));% Jx
    dipole_mom(1) = model.result.numerical('global_eval_QNM').getReal();
    %%%%%%%%%%%%%%%%%%%%%%%
    num_dipole_entity = model.physics('emw').feature(dipole_name).selection().entities(0);
    dipole_pos = mphgetcoords(model,'geom1','point',num_dipole_entity);
else
    fprintf('\n Error : In COMSOL model sheet, electric dipole must be defined by a vector only\n');
    return;
end


% get the E field on the dipole
ddd = mpheval(model,{'Ex','Ey','Ez'},'edim','point','selection',num_dipole_entity,'Complexout','on');
E_source_total = [ddd.d1,ddd.d2,ddd.d3];


% get the E field everywhere
[ex,ey,ez] = mphinterp(model,{'emw.Ex','emw.Ey','emw.Ez'},'coord',XYZ.','Complexout','on');
[epsilon] = mphinterp(model,{'emw.epsilonrxx'},'coord',XYZ.','Complexout','on');



%% Run the COMSOL simulation at 'omega' to get the background field
fprintf('\t Background field calculations on pole frequency\n');

% set
model = mphload(model_file_name);
model.param.set('omega',num2str(omega,'%12.15e'));
model.param.set('myeps_au','myeps_bk');

% run
model.study('std1').run();

% get the E field on the dipole
ddd = mpheval(model,{'Ex','Ey','Ez'},'edim','point','selection',num_dipole_entity,'Complexout','on');
E_source_bg = [ddd.d1,ddd.d2,ddd.d3];

% get the E field everywhere
[ex_temp,ey_temp,ez_temp] = mphinterp(model,{'emw.Ex','emw.Ey','emw.Ez'},'coord',XYZ.','Complexout','on');
ex = ex - ex_temp; clear ex_temp;
ey = ey - ey_temp; clear ey_temp;
ez = ez - ez_temp; clear ez_temp;


%% NORMALIZATION

mydelta = omega_pole - omega; 

E_source_scatt = E_source_total-E_source_bg;
normal_coeff = sqrt(1i*mydelta/dot(dipole_mom,E_source_scatt));
ex_normalized = normal_coeff*ex/sqrt(sym_factor);
ey_normalized = normal_coeff*ey/sqrt(sym_factor);
ez_normalized = normal_coeff*ez/sqrt(sym_factor);
E_source_normalized = normal_coeff*E_source_scatt/sqrt(sym_factor);
ex_normalized = reshape(ex_normalized,length(yp),length(xp),length(zp));
ey_normalized = reshape(ey_normalized,length(yp),length(xp),length(zp));
ez_normalized = reshape(ez_normalized,length(yp),length(xp),length(zp));


%% PLOT DATA
imagesc(zp,yp,squeeze(abs(ez_normalized(:,:))));
colorbar;
axis image;
axis xy;



