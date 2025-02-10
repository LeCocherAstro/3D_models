module queue_aronde_ulanzi_ombra_video(length = 70, shrink = 0) {
    // set "shrink" to 1(mm) for Manfrotto compatibility, or 0 for original model

    width  = 41-shrink;
    height = 10;

    translate([-width/2, length/2, 0]) 
        rotate([90,0,0]) 
            linear_extrude(length) {
                polygon([[0,0],[12,0],[12,3],[width-12,3],[width-12,0],[width,0],[width,3],[width-4,height],[4,height],[0,3]]);
            }
}

queue_aronde_ulanzi_ombra_video(length = 70, shrink = 0);