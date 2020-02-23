# Script based on
# http://grittyengineer.com/vivado-non-project-mode-releasing-vivados-true-potential/
# :)

set part_num xc7a35tftg256-1
set output_dir ./build
file mkdir $output_dir

# set files [glob -nocomplain "$output_dir/*"]
# if {[llength $files] != 0} {
#     puts "deleting compild files in $output_dir"
#     file delete -force {*}[glob -directory $output_dir *];
# } else {
#     puts "$output_dir is empty"
# }
#
#
# # Add HDL files
# read_verilog -sv [ glob ./src/*.sv ]
# #read_xcd ./constraints/constraint.xcd
#
# # Run synthesis
# synth_design -top four_input_xor -part $part_num
# write_checkpoint -force $output_dir/post_synth.dcp
# report_timing_summary -file $output_dir/post_synth_timing_summary.rpt
# report_utilization -file $output_dir/post_synth_util.rpt
#
# #Run optimizations
# opt_design
# place_design
# report_clock_utilization -file $output_dir/clock_util.rpt
#
# set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
# set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
#
# #Route design and generate bitstream
# route_design -directive Explore
# write_checkpoint -force $output_dir/post_route.dcp
# report_route_status -file $output_dir/post_route_status.rpt
# report_timing_summary -file $output_dir/post_route_timing_summary.rpt
# report_power -file $output_dir/post_route_power.rpt
# report_drc -file $output_dir/post_imp_drc.rpt
# write_verilog -force $output_dir/cpu_impl_netlist.v -mode timesim -sdf_anno true
# write_bitstream -force $output_dir/nameOfBitstream.bit
#

#launch_simulation -step all -mode behavioral -simset simulation


# Create project
create_project -force chapter4 $output_dir

# delete_fileset simulation
#delete_fileset sim_1

if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Import local files from the original project
set files [list \
 [file normalize "src/four_input_xor.sv" ]\
 [file normalize "src/two_bit_comparator.sv" ]\
 [file normalize "src/minority.sv" ]\
]
set imported_files [import_files -fileset sources_1 $files]


# Set 'sources_1' fileset file properties for local files
set file "src/four_input_xor.sv"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "src/two_bit_comparator.sv"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "src/minority.sv"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj


# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Import local files from the original project
set files [list \
 [file normalize "simulation/eq2_test_bench.sv" ]\
]
set imported_files [import_files -fileset sim_1 $files]

# Set 'sim_1' fileset file properties for remote files
# None

# Set 'sim_1' fileset file properties for local files
set file "simulation/eq2_test_bench.sv"
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj


# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "eq2_test_bench" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj
