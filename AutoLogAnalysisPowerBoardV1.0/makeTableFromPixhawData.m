
function [pixhwak_log_data_table, message_table]= makeTableFromPixhawData(filelocation, variable_names)
load(filelocation, '-mat', 'RBM1', 'RBM2', 'RMD1', 'RMD2', 'RTOP', 'MSG');

Total_Current=RBM1.TI';
Lower_Rotor_Current=RBM1.E1I';
Upper_Rotor_Current=RBM1.E2I';
BMS_Buck_Current=RBM1.BUI';
BMS_Main_Battery_V=RBM1.TV';
BMS_Microcontroller_Buck_V=RBM1.BUC';
Battery1_Temperature=RBM1.B1T';
Battery2_Temperature=RBM1.B2T';
ESC_Lower_Rotor_Temperature=RBM1.E1T';
ESC_Upper_Rotor_Temperature=RBM1.E2T';
Motor_Lower_Rotor_Temperature=RBM1.M1T';
Motor_Upper_Rotor_Temperature=RBM1.M2T';
Mosfet1_Temperature=RBM1.MO1';
Mosfet2_temperature=RBM1.MO2';
Fault_Detection_Data_Cout=RBM2.ECO';
Fault_Detection_Data_Dout=RBM2.EDO';
Servo4_Current=RMD1.S4I';
Servo5_Current=RMD1.S5I';
Servo6_Current=RMD1.S6I';
Aux_Battery_Current=RMD1.AUXI';
Servo4_Temperature=RMD1.S4T';
Servo5_Temperature=RMD1.S5T';
Servo6_Temperature=RMD1.S6T';
Bec1_V=RMD1.BEC1';
Bec2_V=RMD1.BEC2';
Mid_Converter1_V=RMD1.C1V';
Mid_Converter2_V=RMD1.C2V';
Mid_Converter3_V=RMD1.C3V';
Mid_Converter4_V=RMD1.C4V';
MID_Microcontroller_Buck_V=RMD2.BUC';
Pixhawk_Convertor_V=RMD2.PMV';
Pixhawk_Aux_V=RMD2.PAV';
Pixhawk_Buck_Backup_V=RMD2.PEV';
Jetson_Convertor_V=RMD2.JMV';
Jetson_Buck_Backup_V=RMD2.JEV';
Video_Main_V=RMD2.VMV';
Video_Aux_V=RMD2.VAV';
Mid_Main_Battery_V=RMD2.MV';
Aux_Battery_V=RMD2.AUXV';
TOP_Main_V=RTOP.TV';
Top_Microcontroller_Buck_V=RTOP.BUC';
Top_Converter1_V=RTOP.C1V';
Top_Converter2_V=RTOP.C2V';
Top_Converter3_V=RTOP.C3V';
Top_Converter4_V=RTOP.C4V';
Servo1_Current=RTOP.S1I';
Servo2_Current=RTOP.S2I';
Servo3_Current=RTOP.S3I';
Servo1_Temperature=RTOP.S1T';
Servo2_Temperature=RTOP.S2T';
Servo3_Temperature=RTOP.S3T';
BMS1_Msg_Time = RBM1.TimeUS';
BMS2_Msg_Time = RBM2.TimeUS';
MID1_Msg_Time = RMD1.TimeUS';
MID2_Msg_Time = RMD2.TimeUS';
TOP_Msg_Time = RTOP.TimeUS';

pixhawk_table_array  = padcat(0.001.*BMS1_Msg_Time, 0.001.*BMS2_Msg_Time, 0.001.*MID1_Msg_Time,...
    0.001.*MID2_Msg_Time,Total_Current,Lower_Rotor_Current,...
    Upper_Rotor_Current,BMS_Main_Battery_V,...
    BMS_Microcontroller_Buck_V, BMS_Buck_Current,Battery1_Temperature,Battery2_Temperature,...
    ESC_Lower_Rotor_Temperature,ESC_Upper_Rotor_Temperature,...
    Motor_Lower_Rotor_Temperature,Motor_Upper_Rotor_Temperature,...
    Mosfet1_Temperature,Mosfet2_temperature,Fault_Detection_Data_Cout,...
    Fault_Detection_Data_Dout,Servo4_Current,Servo5_Current,...
    Servo6_Current,Aux_Battery_Current,Servo4_Temperature,Servo5_Temperature,...
    Servo6_Temperature,Bec1_V,Bec2_V,Mid_Converter1_V,Mid_Converter2_V,...
    Mid_Converter3_V,Mid_Converter4_V,MID_Microcontroller_Buck_V,...
    Pixhawk_Convertor_V,Pixhawk_Aux_V,Pixhawk_Buck_Backup_V,Jetson_Convertor_V,...
    Jetson_Buck_Backup_V,Video_Main_V,Video_Aux_V,Mid_Main_Battery_V,...
    Aux_Battery_V,TOP_Main_V,Top_Microcontroller_Buck_V,Top_Converter1_V,...
    Top_Converter2_V,Top_Converter3_V,Top_Converter4_V,Servo1_Current,Servo2_Current,...
    Servo3_Current,Servo1_Temperature,Servo2_Temperature,Servo3_Temperature,...
    0.001.*TOP_Msg_Time);

pixhawk_table_array(pixhawk_table_array==-1) = nan;

pixhwak_log_data_table = array2table(pixhawk_table_array,...
    "VariableNames",["BMS1_Msg_Time", "BMS2_Msg_Time", "MID1_Msg_Time",...
                     "MID2_Msg_Time", variable_names, "TOP_Msg_Time"]);

message_array = string;

for i = 1:1:size(MSG.Message,1)
message_array(i) = convertCharsToStrings(MSG.Message(i,:));
end
power_msg_index = find(contains(message_array(:), 'Power'));
time_ms = 0.001.*MSG.TimeUS(power_msg_index)';

Error_Messages = message_array(power_msg_index)';
message_table = table(time_ms, Error_Messages);

end
