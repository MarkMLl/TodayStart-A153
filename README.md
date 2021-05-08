# TodayStart-A153
As-shipped demo for the Altera Cyclone TodayStart-A153 board. Requires Quartus-II 10.1 SP1 minimum.

<pre>// This is derived from the TodayStart example key_led.v, which wasn't reliable
// for multiple reasons. The comprehensive CASE statement has been replaced by
// a much smaller number of IFs, and operation has been made synchronous without
// which the initial state was undefined (this board only has a clock on CLK3,
// see http://kiedontaa.blogspot.com/2019/12/gameboy-to-vga.html for comments).
//
// Assume for the purpose of maintenance that there are now two files key_led.v
// and key_led.vhd, use one or the other as Quartus's top-level entity. MarkMLl</pre>
