function comm_errors = converCommEnum2str(comm_errors_number)

comm_errors(comm_errors_number==0) = "Communication Healthy";
comm_errors(comm_errors_number==1) = "Top Board Commnunication Error";
comm_errors(comm_errors_number==2) = "Mid Board Commnunication Error";
comm_errors(comm_errors_number==3) = "Mid & Top Board Commnunication Error";
comm_errors(comm_errors_number==4) = "BMS Board Commnunication Error";
comm_errors(comm_errors_number==5) = "BMS & Mid Board Commnunication Error";
comm_errors(comm_errors_number==6) = "BMS & Top Board Commnunication Error";
comm_errors(comm_errors_number==7) = "BMS,Mid & Top Board Commnunication Error";

end