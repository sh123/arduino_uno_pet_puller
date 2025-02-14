include <OpenSCAD-Arduino-Mounting-Library/arduino.scad>

// type of board
cfg_board_type_ = DUEMILANOVE;       // [DUEMILANOVE, UNO]

// element to generate
cfg_generate_element_ = "box";       // [box, lid]

// include arduino board
cfg_include_board_ = "no";           // [yes, no]

// box additional height
cfg_additional_height_ = 22;

// wall width
cfg_wall_width_ = 2;

// space between board and wall
cfg_wall_board_space_ = 3;

if (cfg_generate_element_ == "box")
{
   box_generate(cfg_board_type_, cfg_include_board_, cfg_wall_width_, cfg_wall_board_space_, cfg_additional_height_);
}
else if (cfg_generate_element_ == "lid") 
{
    lid_generate(cfg_board_type_, cfg_wall_width_, cfg_wall_board_space_);
}
else
{
    echo("Unknown element", cfg_generate_element_);
}

// generate box
module box_generate(board_type, include_board, wall_width, wall_board_space, additional_height)
{
    // old power socket
    old_socket_x = 39;
    old_socket_y = -5;
    old_socket_z = 7;
    
    // vent holes
    vent_hole_count = 14;
    vent_hole_height = 12;
    vent_hole_width = 2;
    vent_hole_span = 75;
    vent_hole_x = -10;
    vent_hole_y = 5;
    vent_hole_z = 17;
    
    // cable hole
    cable_hole_width = 50;
    cable_hole_height = 10;
    cable_hole_x = 1;
    cable_hole_y = 70;
    cable_hole_z = 22;
    
    // power cable hole
    power_hole_width = 12;
    power_hole_height = 14;
    power_hole_x = 26.5;
    power_hole_y = -6;
    power_hole_z = 20;
    
    // common
    extrude_width = 14;
    
    difference() 
    {
        // case
        union()
        {
            if (include_board == "yes") 
            {
                translate([0, 0, 7])
                    arduino(board_type);
                        enclosure(board_type, wall_width, wall_board_space, additional_height);
            } else {
                enclosure(board_type, wall_width, wall_board_space, additional_height);
            }
            // close old power socket
            translate([old_socket_x, old_socket_y, old_socket_z])
                cube([power_hole_width, wall_width, power_hole_height]);
        } 
        // add vent holes
        for (vent_hole_num = [0:vent_hole_count])
        {
            translate([vent_hole_x, vent_hole_y + vent_hole_num * 4, vent_hole_z])
                cube([vent_hole_span, vent_hole_width, vent_hole_height]);
        }
        // cable hole
        translate([cable_hole_x, cable_hole_y, cable_hole_z])
            cube([cable_hole_width, extrude_width, cable_hole_height]);
        // connector hole
        translate([power_hole_x, power_hole_y, power_hole_z])
            cube([power_hole_width, extrude_width, power_hole_height]);
    }
}

// generates lid
module lid_generate(board_type, wall_width, wall_board_space) 
{
    // led
    led_hole_radius = 3;
    led_x = 10;
    led_y = 18;
    
    // fan
    fan_screw_radius = 1.5;
    fan_hole_radius = 14;
    fan_x = 28;
    fan_y = 35;
    
    // fan holes
    hole_base_x = 16;
    hole_base_y = 22.5;
    hole_distance = 24;
    
    // common
    cylinder_height = 10;
    z_position = -2;
    
    difference() 
    {
        // enclosure body
        enclosureLid(board_type, wall_width, wall_board_space);
        // fan hole
        translate([fan_x, fan_y, z_position])
            cylinder(cylinder_height, fan_hole_radius, fan_hole_radius);
        // screw holes for fan
        translate([hole_base_x + hole_distance, hole_base_y + hole_distance, z_position])
            cylinder(cylinder_height, fan_screw_radius, fan_screw_radius);
        translate([hole_base_x, hole_base_y + hole_distance, z_position])
            cylinder(cylinder_height, fan_screw_radius, fan_screw_radius);
        translate([hole_base_x + hole_distance, hole_base_y, z_position])
            cylinder(cylinder_height, fan_screw_radius, fan_screw_radius);
        translate([hole_base_x, hole_base_y, z_position])
            cylinder(cylinder_height, fan_screw_radius, fan_screw_radius);
        // led hole
        translate([led_x, led_y, z_position])
            cylinder(cylinder_height, led_hole_radius, led_hole_radius);
    }
}