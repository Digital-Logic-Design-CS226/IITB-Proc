transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/XOR_gate.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Testbench1.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Temp_LA_SA.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Status_Registers.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/SixteenbitNAND.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/SixteenbitKogStonAddSub.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Sign_extender_six.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Sign_extender_nine.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/RISC.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/RF_RA_input.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/RF_input_process.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/RF_datain_process.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Register_file.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/PC_write.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/PC.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/OR_gate.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/NOT_gate.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/memory_address_input.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/memory.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Instruction_register.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Instruction_memory.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/GroupGenerator.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/generator.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Data_path.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Control_unit.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Carry_oper.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/AND_gate.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/ALU_input_logic.vhd}
vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/ALU.vhd}

vcom -93 -work work {D:/IITB/Semester 4/CS 226/Project/IITB-Proc/Testbench1.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L maxv -L rtl_work -L work -voptargs="+acc"  Testbench1

add wave *
view structure
view signals
run -all
