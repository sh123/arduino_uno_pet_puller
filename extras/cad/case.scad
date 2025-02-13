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
            translate([39, -5, 7])
                cube([12, wall_width, 14]);
        } 
        // add vent holes
        for (vent_hole_num = [0:14])
        {
            translate([-10, 5 + vent_hole_num * 4, 17])
                cube([75, 2, 12]);
        }
        // cable hole
        translate([1, 70, 22])
            cube([50, 20, 10]);
        // connector hole
        translate([27.5, -6, 22])
            cube([12, wall_width+2, 14]);
    }
}

// generates lid
module lid_generate(board_type, wall_width, wall_board_space) 
{
    enclosureLid(board_type, wall_width, wall_board_space);
}