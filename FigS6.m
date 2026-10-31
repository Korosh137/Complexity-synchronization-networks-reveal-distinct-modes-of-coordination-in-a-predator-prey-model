%% RUN_CS_STATISTICAL_VALIDATION
% Run Fig6_CvsCS_MDEA and Fig7_CvsCS_DFA first (patched scripts save data).
% Independent ensembles are resampled AS UNITS; overlapping windows are not
% treated as independent observations. R-sweep is descriptive, not randomized.
clear; clc; close all;
root = fullfile(pwd,'CS_STAT_VALIDATION');
if ~exist(root,'dir'), mkdir(root); end
nBoot=5000; rng(137,'twister');
methods={'MDEA','DFA'}; names={'I1-I2','I2-T1','I1-P2'};
rows={}; fig=figure('Visible','off','Color','w','Position',[100 100 1100 650]);
tiledlayout(2,3,'TileSpacing','compact','Padding','compact');
for im=1:2
    file=fullfile(root,[methods{im} '_ensemble_data.mat']);
    if ~isfile(file), error('Missing %s. Run patched Fig6 and Fig7 from the same working directory.',file); end
    D=load(file); Y=double(D.AACC); n=size(Y,2); m=size(Y,1);
    if n<3, error('Need at least 3 independent ensembles, found %d',n); end
    for k=1:3
        X=double(D.(sprintf('AACS%d',k)));
        if ndims(X)==3, X=X(:,:,min(2,size(X,3))); end % middle stripe, 0.01
        if size(X,1)~=m || size(X,2)~=n, error('Unexpected data dimensions'); end
        % Per-ensemble slopes across sensing radii. Independent unit = simulation.
        slopes=nan(n,1);
        for e=1:n
            ok=isfinite(X(:,e)) & isfinite(Y(:,e));
            if nnz(ok)>=5 && std(X(ok,e))>0
                z=polyfit(X(ok,e),Y(ok,e),1); slopes(e)=z(1);
            end
        end
        slopes=slopes(isfinite(slopes)); nn=numel(slopes);
        if nn<3, continue; end
        bmean=nan(nBoot,1);
        for b=1:nBoot, ix=randi(nn,nn,1); bmean(b)=mean(slopes(ix)); end
        ci=prctile(bmean,[2.5 97.5]);
        % Two-sided sign-flip test of ensemble slope mean, exchangeability assumption.
        obs=abs(mean(slopes)); null=zeros(nBoot,1);
        for b=1:nBoot, null(b)=abs(mean(slopes.*(2*(rand(nn,1)>.5)-1))); end
        p=(1+sum(null>=obs))/(nBoot+1);
        rows(end+1,:)={methods{im},names{k},nn,mean(slopes),ci(1),ci(2),p}; %#ok<SAGROW>
        nexttile((im-1)*3+k);
        plot(1:nn,slopes,'ko','MarkerFaceColor',[.5 .5 .5]);hold on;
        yline(0,'k:'); yline(mean(slopes),'b-','LineWidth',1.5);
        yline(ci(1),'r--');yline(ci(2),'r--');
        xlabel('Independent ensemble');ylabel('Cr vs CS slope');
        title(sprintf('%s %s; p=%.3g',methods{im},names{k},p));
        set(gca,'FontName','Arial','FontSize',11);grid on;
    end
end
T=cell2table(rows,'VariableNames',{'Estimator','Pair','N_ensembles','MeanSlope','CI95_low','CI95_high','SignFlip_p'});
% Holm correction across all six planned tests.
p=T.SignFlip_p;[ps,ord]=sort(p);adj=zeros(size(p));for i=1:numel(p),adj(ord(i))=min(1,max((numel(p)-(1:i)+1)'.*ps(1:i)));end
T.Holm_p=adj;
writetable(T,fullfile(root,'Ensemble_slope_validation.csv'));
exportgraphics(fig,fullfile(root,'Ensemble_slope_validation.pdf'),'ContentType','vector');close(fig);
% Rescue comparison: independent simulation replicates, not overlapping windows.
files=dir(fullfile(pwd,'**','CS_Guided_Rescue_Figures_A_B_C_PARFOR_results.mat'));
if ~isempty(files)
    Q=load(fullfile(files(1).folder,files(1).name));
    if all(isfield(Q,{'Cr_target','Cr_random','Cr_global','sList'}))
        f=figure('Visible','off','Color','w','Position',[100 100 850 480]);hold on;
        vals={Q.Cr_target,Q.Cr_random,Q.Cr_global};labs={'Targeted','Non-targeted local','Global'};
        for j=1:3
            A=double(vals{j});if size(A,1)~=numel(Q.sList),A=A';end
            plot(Q.sList,mean(A,2,'omitnan'),'LineWidth',1.7,'DisplayName',labs{j});
        end
        xlabel('Rescue strength');ylabel('Cooperation rate');legend('Location','northwest');
        title('Independent-ensemble recovery curves (descriptive)');grid on;
        exportgraphics(f,fullfile(root,'Rescue_independent_ensembles.pdf'),'ContentType','vector');close(f);
        % For a confirmatory intervention comparison use a matched-seed design,
        % or a two-sample independent-ensemble test, and ensure ENS >= 10.
    end
end
disp(T);fprintf('Outputs: %s\n',root);
