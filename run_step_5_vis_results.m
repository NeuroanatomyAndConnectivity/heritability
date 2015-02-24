function[] = run_step_5_vis_results(prefix)

surf_gii = gifti(['/scr/murg2/HCP_new/HCP_Q1-Q6_GroupAvg_Related440_Unrelated100_v1/Q1-Q6_R440.L.inflated.32k_fs_LR.surf.gii']);
surf.coord = surf_gii.vertices';
surf.tri = surf_gii.faces;

data = load('data.mat');

h = figure('visible','off'); 

SurfStatView(data.cov, surf, 'covariance');
saveas(h, ['fig_' prefix 'covariance.png']);
disp('Made fig cov');

SurfStatView(data.p, surf, 'pvalues');
saveas(h, ['fig_' prefix 'pval.png']);
disp('Made fig p');

SurfStatView(data.h2r, surf, 'h2r');
saveas(h, ['fig_' prefix 'h2r.png']);
disp('Made fig h2r');

SurfStatView(data.se, surf, 'se');
saveas(h, ['fig_' prefix 'se.png']);
disp('Made fig se');
