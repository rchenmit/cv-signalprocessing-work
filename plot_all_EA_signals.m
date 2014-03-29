%% PLOT all signals

%% specify save dir; mkdir if it doesn't exist
savedir = './output_figures/';
if ~exist(savedir, 'dir')
  mkdir(savedir);
end

%labels for the scenario: specified by me!
scenario_labels = {'AFC_NormBreath', 'AFC_BreathOutHold', 'AFC_Valsalva', 'AFC_Valsalva', 'PSLAX_NormBreath', 'PSLAX_BreathOutHold', 'AFC_Valsalva', 'AFC_Valsalva'};
%% loop thru all scenarios and plot
for i = 1:length(struct_this_subject_data.scenario_names)
    this_scenario_name = struct_this_subject_data.scenario_names{i};
    deviation_EA = struct_this_subject_data_processed.deviation_EA{i};
    scgSt_velocity = struct_this_subject_data_processed.scgSt_velocity{i};
    scgPmi_velocity = struct_this_subject_data_processed.scgPmi_velocity{i};
    scgSt_position = struct_this_subject_data_processed.scgSt_position{i};
    scgPmi_position = struct_this_subject_data_processed.scgPmi_position{i};
    cond_ecgHW_EA = struct_this_subject_data_processed.cond_ecgHW_EA{i};
    cond_scgSt_EA = struct_this_subject_data_processed.cond_scgSt_EA{i};
    cond_scgPmi_EA = struct_this_subject_data_processed.cond_scgPmi_EA{i};
    
    %figure for deviation_EA + scgSt_velocity + scgPmi_velocity
    figure
    hold on
    plot(cond_ecgHW_EA, '-b')
    plot(cond_scgSt_EA, '-r')
    plot(cond_scgPmi_EA, '-g')
    title(strcat(scenario_labels{i}, ': ecgHW\_EA, scgSt\_EA, scgPmi\_EA'))
    legend('ecgHW\_EA', 'scgSt\_EA', 'scgPmi\_EA')
    savestr = strcat(savedir, 'plot_', this_scenario_name, '_', scenario_labels{i}, '_cond_ecgHW_EA', '_cond_scgSt_EA', '_cond_scgPmi_EA');
    saveas(gcf, savestr, 'png');
    
    %figure for deviation_EA + scgSt_velocity + scgPmi_velocity
    figure
    hold on
    downsample_factor_HW = ceil(length(scgSt_velocity) / length(deviation_EA));
    scale = 4e4;%% change scale if need be
    shift_deviationEA = mean(scgSt_velocity)/scale;%% how much to shift deviation on the figure; change if need be
    plot(deviation_EA + shift_deviationEA, '-b')
    plot(scgSt_velocity(1:downsample_factor_HW:end)/scale, '-*r')
    plot(scgPmi_velocity(1:downsample_factor_HW:end)/scale, '-*b')
    title(strcat(scenario_labels{i}, ': deviation EA, scgSt\_velocity EA, scgPmi\_velocity'))
    legend('deviation\_EA', 'scgSt\_velocity', 'scgPmi\_velocity')
    savestr = strcat(savedir, 'plot_', this_scenario_name, '_',  scenario_labels{i},'_deviation_EA', '_scgSt_velocity', 'scgPmi_velocity');
    saveas(gcf, savestr, 'png');
    
    %figure for deviation_EA + scgSt_position + scgPmi_position
    figure
    hold on
    downsample_factor_HW = ceil(length(scgSt_velocity) / length(deviation_EA));
    scale = 4e7;%% change scale if need be
    shift_deviationEA = mean(scgSt_velocity)/scale;%% how much to shift deviation on the figure; change if need be
    plot(deviation_EA + shift_deviationEA, '-b')
    plot(scgSt_position(1:downsample_factor_HW:end)/scale, '-*r')
    plot(scgPmi_position(1:downsample_factor_HW:end)/scale, '-*b')
    title(strcat(scenario_labels{i}, ': deviation EA, scgSt\_position EA, scgPmi\_position'))
    legend('deviation\_EA', 'scgSt\_position', 'scgPmi\_position')
    savestr = strcat(savedir, 'plot_', this_scenario_name, '_', scenario_labels{i}, '_deviation_EA', '_scgSt_position', 'scgPmi_position');
    saveas(gcf, savestr, 'png');
    
    %figure for ecgEcho, deviation_EA, ecgHW, scgSt_velocity,
    %scgPmi_velocity
    figure
    hold on
    downsample_factor_HW = ceil(length(scgSt_velocity) / length(deviation_EA));
    downsample_factor_echoEcg = ceil(length(scgSt_velocity) / length(cond_ecgEcho));
    scale = 4e4;%% change scale if need be
    scale_ecgEcho = 4e3;
    shift_deviationEA = mean(scgSt_velocity)/scale;%% how much to shift deviation on the figure; change if need be
    plot(cond_ecgHW_EA(1:downsample_factor_HW:end)/scale_ecgEcho, '-gv')
    plot(deviation_EA + shift_deviationEA, '-b')
    plot(scgSt_velocity(1:downsample_factor_HW:end)/scale, '-*r')
    plot(scgPmi_velocity(1:downsample_factor_HW:end)/scale, '-*b')
    title(strcat(scenario_labels{i}, ': ecgHW\_EA, deviation EA, scgSt\_velocity EA, scgPmi\_velocity'))
    legend('ecgHW\_EA', 'deviation\_EA', 'scgSt\_velocity', 'scgPmi\_velocity')
    savestr = strcat(savedir, 'plot_', this_scenario_name, '_',  scenario_labels{i},'_ecgHW','_deviation_EA',  '_scgSt_velocity', 'scgPmi_velocity');
    saveas(gcf, savestr, 'png');
  
end