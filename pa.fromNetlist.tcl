
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name aes -dir "C:/Users/HP/Desktop/University/Academics/Capstone/aes/planAhead_run_2" -part xc6slx16csg324-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/HP/Desktop/University/Academics/Capstone/aes/fpga_impl.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/HP/Desktop/University/Academics/Capstone/aes} }
set_property target_constrs_file "nexys3.ucf" [current_fileset -constrset]
add_files [list {nexys3.ucf}] -fileset [get_property constrset [current_run]]
link_design
