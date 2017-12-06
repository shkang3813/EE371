onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sendblock_testbench/clk
add wave -noupdate /sendblock_testbench/reset
add wave -noupdate /sendblock_testbench/transmiting
add wave -noupdate /sendblock_testbench/load
add wave -noupdate /sendblock_testbench/busin
add wave -noupdate /sendblock_testbench/outbit
add wave -noupdate /sendblock_testbench/whichbit
add wave -noupdate /sendblock_testbench/midpoint
add wave -noupdate -radix decimal -childformat {{{/sendblock_testbench/datakept[9]} -radix decimal} {{/sendblock_testbench/datakept[8]} -radix decimal} {{/sendblock_testbench/datakept[7]} -radix decimal} {{/sendblock_testbench/datakept[6]} -radix decimal} {{/sendblock_testbench/datakept[5]} -radix decimal} {{/sendblock_testbench/datakept[4]} -radix decimal} {{/sendblock_testbench/datakept[3]} -radix decimal} {{/sendblock_testbench/datakept[2]} -radix decimal} {{/sendblock_testbench/datakept[1]} -radix decimal} {{/sendblock_testbench/datakept[0]} -radix decimal}} -expand -subitemconfig {{/sendblock_testbench/datakept[9]} {-radix decimal} {/sendblock_testbench/datakept[8]} {-radix decimal} {/sendblock_testbench/datakept[7]} {-radix decimal} {/sendblock_testbench/datakept[6]} {-radix decimal} {/sendblock_testbench/datakept[5]} {-radix decimal} {/sendblock_testbench/datakept[4]} {-radix decimal} {/sendblock_testbench/datakept[3]} {-radix decimal} {/sendblock_testbench/datakept[2]} {-radix decimal} {/sendblock_testbench/datakept[1]} {-radix decimal} {/sendblock_testbench/datakept[0]} {-radix decimal}} /sendblock_testbench/datakept
add wave -noupdate /sendblock_testbench/srclk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {305025 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3268125 ps}
