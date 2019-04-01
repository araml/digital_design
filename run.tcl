# Script based on
# http://grittyengineer.com/vivado-non-project-mode-releasing-vivados-true-potential/
# :)

set part_num xc7a35tftg256-1
set output_dir ./build
file mkdir $output_dir

set files [glob -nocomplain "$output_dir/*"]
if {[llength $files] != 0} {
    puts "deleting compild files in $output_dir"
    file delete -force {*}[glob -directory $output_dir *];
} else {
    puts "$output_dir is empty"
}


# Add HDL files
read_verilog -sv [ glob ./src/*.sv ]
#read_xcd ./constraints/constraint.xcd

# Run synthesis
synth_design -top four_input_xor -part $part_num
write_checkpoint -force $output_dir/post_synth.dcp
report_timing_summary -file $output_dir/post_synth_timing_summary.rpt
report_utilization -file $output_dir/post_synth_util.rpt

#Run optimizations
opt_design
place_design
report_clock_utilization -file $output_dir/clock_util.rpt

#Route design and generate bitstream
# route_design -directive Explore
# write_checkpoint -force $output_dir/post_route.dcp
# report_route_status -file $output_dir/post_route_status.rpt
# report_timing_summary -file $output_dir/post_route_timing_summary.rpt
# report_power -file $output_dir/post_route_power.rpt
# report_drc -file $output_dir/post_imp_drc.rpt
# write_verilog -force $output_dir/cpu_impl_netlist.v -mode timesim -sdf_anno true
# write_bitstream -force $output_dir/nameOfBitstream.bit


#launch_simulation -step all -mode behavioral -simset simulation


# Create project
create_project -force chapter4 $output_dir

# delete_fileset simulation
#delete_fileset sim_1
create_fileset -simset simulation
add_files -fileset simulation ./simulation/eq2_test_bench.sv
set_property top eq2_test_bench [get_filesets simulation]
