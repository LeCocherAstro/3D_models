$fn=360;
chouilla = 0.02;

include <BOLTS/bolts.scad>
include <BOSL/constants.scad>
use <BOSL/shapes.scad>

//------------------------------------------------------------------
// 0 = sans rotule à gauche, 1 = avec rotule
avec_rotule = 1; 
// 1 = grande barre et 2 vis de fixation, 0 = petite barre et une vis de fixation
// Modifier longeur de la barre en ligne 291
grande_barre = 1; 


//------------------------------------------------------------------
//------------------------------------------------------------------
union() 
{
  color("DarkKhaki") attache_inferieur();
  attache_superieur();
}
//barre();
//------------------------------------------------------------------
//------------------------------------------------------------------

marge = 0.1;

// Demi cylindre
d_int = 63.15+0.1;
epaisseur = 5;
largeur = 12; //10;

// Passage de la vis de serrage, partie de droite
l_fixation_droite = 10;
e_fixation_droite = 5;
marge_fixation_droite = 1; // Afin d'encaster la pièce dans le demi cylindre
ajustement_position_piece_droite = -4; // Pour ne pas faire un bout trop long
d_fixation_droite = 4;     // Diametre vis de fixation, vis M4
d_fixation_gauche = 4;     // Vis M4
ecartement_fixation_gauche = -2.5;
epaisseur_connecteur = 3;
e_fixation_droite_a_retirer = 1; // Afin de bien fixer la lunette et éviter du jeu

// Pièce pour joindre les 2 attaches - vis à vis partie inferieure
e_fixation_gauche  = 3;   // Partie centrale de la fix ation
e1_fixation_gauche = 4.5;   // Côté vis 
e2_fixation_gauche = largeur - e_fixation_gauche - e1_fixation_gauche; // Opposée côté vis
h_fixation_gauche  = 5;
h_a_retirer        = 5.5;  // hauteur de matière a retirer de la pièce du dessus

// Taille écrous
epaisseur_ecrou_M4 = 3.2;  // Epaisseur ecrou M4
d_tete_vis_M4 = 7+1;         // Diamètre tete de vis M4 + de la marge !    
profondeur_tete_vis_M4 = 3;
//epaisseur_ecrou_M2 = 1.6;  // Epaisseur ecrou M2

// Base
base = 36;
h_base = 10;
d_fixation_queue = 4;

// Espacement entre les 2 vis de fixation
// 24 sur la version 1 mais manque de matière !
// Le collier était 
dist_fixation_queue = 22;  

// Dessus
base_dessus = 32;
h_dessus = 0;
d_fixation_centrale = 4;     // Diametre vis de fixation

ajustement_placement_trou_attache_gauche = -2.5;
    
    
//------------------------------------------------------------------
// Demi cylindre
//------------------------------------------------------------------
module hollowcylindersector(height, radius, angle=360, intradius=0, center=false)
{
  translate ([0, 0, center?(-height/2):0])
    rotate (center?(-angle/2):0, [0, 0, 1])
      rotate_extrude(angle = angle, convexity = 2)
        polygon([[intradius, 0],[intradius, height],[radius, height],[radius, 0]]);
}

//------------------------------------------------------------------
// Triangle
//------------------------------------------------------------------
module prism(l, w, h)
{
  polyhedron(//pt 0        1        2        3        4        5
         points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
         faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
}


//------------------------------------------------------------------
// Option : base plane sur le dessus
module dessus()
{
  translate([-base_dessus/2,d_int/2,0]) cube([base_dessus,epaisseur+h_dessus,largeur],center=false); 
}


//------------------------------------------------------------------
module attache_superieur_matiere()
{
  if(avec_rotule == 1)
  {
    // Demi-cercle de diamètre interieur d_int
  hollowcylindersector(height = largeur, radius = d_int/2+epaisseur, angle = 180, intradius = d_int/2);
  }
  else
  {
    // Cercle complet de diamètre interieur d_int
    // On ajoute donc pac de demi-cylindre pour la partie du bas
    hollowcylindersector(height = largeur, radius = d_int/2+epaisseur, angle = 360, intradius = d_int/2);   
  }


  // Attache à droite
  // Passage de la vis de serrage de droite
  // Ajout d'un cube
  translate([d_int/2+epaisseur-marge_fixation_droite,0,0]) cube([l_fixation_droite+marge_fixation_droite+ajustement_position_piece_droite,e_fixation_droite,largeur],center=false);
    
  // Ajout d'un demi cylindre pour arrondir les angle
    translate([d_int/2+epaisseur+l_fixation_droite+ajustement_position_piece_droite,e_fixation_droite,largeur/2]) rotate([90,90,0]) hollowcylindersector(height = e_fixation_droite, radius = largeur/2, angle = 180, intradius = 0);

  if(avec_rotule == 1)
  {
    // Attache à gauche
    // Ajout cylindre pour la fixation gauche
    translate([-(d_int+epaisseur)/2+ecartement_fixation_gauche,0,e2_fixation_gauche]) rotate([0,0,180]) hollowcylindersector(height = e_fixation_gauche, radius = d_fixation_gauche/2+epaisseur_connecteur, angle = 360, intradius = 0); 
  }
  
  // Ajout d'un renfort sur la droite au niveau des angles droits
  translate([d_int/2+epaisseur+0.9,e_fixation_droite,largeur]) rotate([0,90,90]) prism(l=largeur, w=2.5, h=5);  
    
  // Base du dessus
  dessus();
  
  if(avec_rotule == 0)
  {
    // Ajout base
    base();
  }
     
}


module attache_superieur()
{
  difference()
  {
    attache_superieur_matiere();
 
    if(avec_rotule == 1)
    {     
      // Attache côté gauche
      // Supression de matière pour assurer une rotation des pièces !
      // En bas      
      translate([-(d_int+epaisseur)/2+ecartement_fixation_gauche,0,0]) 
    rotate([0,0,180]) hollowcylindersector(height = e2_fixation_gauche+0.5*marge, radius = d_fixation_gauche/2+epaisseur_connecteur+5*marge, angle = 360, intradius = 0);  
        
      // En haut  
      translate([-(d_int+epaisseur)/2+ecartement_fixation_gauche,0,e2_fixation_gauche+e_fixation_gauche-0.5*marge]) 
    rotate([0,0,180]) hollowcylindersector(height = e1_fixation_gauche+2*marge, radius = d_fixation_gauche/2+epaisseur_connecteur+5*marge, angle = 360, intradius = 0);           
    }
       
      
    // trou diam 4mm pour vis de l'attache de droite
    translate([d_int/2+epaisseur+l_fixation_droite/2,e_fixation_droite/2,largeur/2]) rotate([90,0,0]) cylinder(h=e_fixation_droite+6*chouilla, d=d_fixation_droite+3*chouilla, center=true);
 
    // Trou pour la tête de vis de droite
    translate([d_int/2+epaisseur+l_fixation_droite/2,e_fixation_droite-profondeur_tete_vis_M4/2+chouilla,largeur/2]) rotate([90,0,0]) cylinder(h=profondeur_tete_vis_M4, d=d_tete_vis_M4, center=true);
 
    if(avec_rotule == 1)
    {     
      // trou diam 4mm pour vis de l'attache de gauche
      translate([-(d_int/2+epaisseur/2)+ecartement_fixation_gauche,-h_fixation_gauche/2-ajustement_placement_trou_attache_gauche,e_fixation_gauche/2 + largeur/4]) cylinder(h=e_fixation_gauche+6*chouilla, d=d_fixation_gauche+3*chouilla, center=true);     
    }
      
    // Passage vis sur la base du dessus
    ajustement3 = 1;
    translate([0,(d_int+epaisseur)/2,largeur/2]) rotate([90,0,0]) cylinder(h=epaisseur+ajustement3, d=d_fixation_centrale, center=true);    
    
    // Trou pour mettre une vis M4
    translate([0,d_int/2+epaisseur_ecrou_M4+3*chouilla,largeur/2]) rotate([90,0,0]) ISO4032("M4");
    // Complement pour bien supprimer la matière au niveau de la vis M4
     translate([0,d_int/2+epaisseur_ecrou_M4-10*chouilla,largeur/2]) rotate([90,0,0]) ISO4032("M4");   
    
    
    // Supression de matière à droite pour assurer un bon maintien de la lunette
    translate([(d_int+epaisseur+l_fixation_droite)/2,e_fixation_droite_a_retirer/2,largeur/2]) cube([1.5*(epaisseur+l_fixation_droite),e_fixation_droite_a_retirer,1.5*largeur],center=true);
    
    if(avec_rotule == 0)
    {
      // Trou pour fixer le collier du bas sur une queue d'aronde
      trou_fixation_queue_aronde();
    }
    
  }
}
   

//------------------------------------------------------------------
module base()
{
  difference()
  {
    translate([-base/2,-(d_int/2+epaisseur+h_base),0]) cube([base,epaisseur+h_base,largeur],center=false); 
    cylinder(h=largeur, d=d_int+epaisseur, center=false);  
  }
}

module attache_inferieur_matiere()
{
    
  if(avec_rotule == 1)
  {
    // Demi-cercle de diamètre interieur d_int
    rotate([0,0,180]) hollowcylindersector(height = largeur, radius = d_int/2+epaisseur, angle = 180, intradius = d_int/2);
  }

  // Passage de la vis de serrage de droite
  // Ajout d'un cube
  translate([d_int/2+epaisseur-marge_fixation_droite,-e_fixation_droite,0]) cube([l_fixation_droite+marge_fixation_droite+ajustement_position_piece_droite,e_fixation_droite,largeur],center=false);
  // Ajout d'un demi cylindre pour arrondir les angles
  translate([d_int/2+epaisseur+l_fixation_droite+ajustement_position_piece_droite,0,largeur/2]) rotate([90,90,0]) hollowcylindersector(height = e_fixation_droite, radius = largeur/2, angle = 180, intradius = 0);
    
  

    
  if(avec_rotule == 1)
  {      
    // Ajout base
    base();
      
    // Ajout de 2 cylindres pour l'attache de gauche
    // Côté vis
    translate([-(d_int+epaisseur)/2+ecartement_fixation_gauche,0,e2_fixation_gauche+e_fixation_gauche]) rotate([0,0,180]) hollowcylindersector(height = e1_fixation_gauche, radius = d_fixation_gauche/2+epaisseur_connecteur, angle = 360, intradius = 0);    

    // Opposée vis, en bas
    translate([-(d_int+epaisseur)/2+ecartement_fixation_gauche,0,0]) 
    rotate([0,0,180]) hollowcylindersector(height = e2_fixation_gauche, radius = d_fixation_gauche/2+epaisseur_connecteur, angle = 360, intradius = 0);
  }
  
  // Ajout d'un renfort sur la droite au niveau des angles droits
  translate([d_int/2+epaisseur-1.4,-e_fixation_droite-5,largeur]) 
  rotate([0,90,0]) prism(l=largeur, w=5, h=2.8);
  
    
}


module trou_fixation_queue_aronde()
{
    // Trou fixation vers queue d'aronde à droite
    ajustement1 = 10;  // Afin d'avoir un trou complet
    ajustement2 =  4;  // Afin que la tête de vis ne dépasse pas !
    
    translate([dist_fixation_queue/2,-(d_int/2+epaisseur+h_base*1/4),largeur/2]) rotate([90,0,0]) cylinder(h=epaisseur+h_base+ajustement1, d=d_fixation_queue, center=true);
    
    // Trou de la vis de droite
    translate([dist_fixation_queue/2,-(d_int/2-(epaisseur+h_base+ajustement1)/2)-ajustement2,largeur/2]) rotate([90,0,0]) cylinder(h=epaisseur+h_base+ajustement1, d=d_tete_vis_M4, center=true);

    // Trou fixation vers queue d'aronde à gauche
    translate([-dist_fixation_queue/2,-(d_int/2+epaisseur+h_base*1/4),largeur/2]) rotate([90,0,0]) cylinder(h=epaisseur+h_base+ajustement1, d=d_fixation_queue, center=true);
    
    // Trou de la vis à gauche
    translate([-dist_fixation_queue/2,-(d_int/2-(epaisseur+h_base+ajustement1)/2)-ajustement2,largeur/2]) rotate([90,0,0]) cylinder(h=epaisseur+h_base+ajustement1, d=d_tete_vis_M4, center=true);  
}


module attache_inferieur()
{
  difference()
  {
    attache_inferieur_matiere();
      
    // trou diam 4mm pour vis de l'attache de droite
    translate([d_int/2+epaisseur+l_fixation_droite/2,-e_fixation_droite/2,largeur/2]) rotate([90,0,0]) cylinder(h=e_fixation_droite+6*chouilla, d=d_fixation_droite+3*chouilla, center=true);  
      
    // Ecrou M4 à droite
    translate([d_int/2+epaisseur+l_fixation_droite/2,-e_fixation_droite+epaisseur_ecrou_M4-0*chouilla,largeur/2]) rotate([90,0,0]) ISO4032("M4");
    // Complement pour bien enlever toute la matière au niveau de la vis M4 
    translate([d_int/2+epaisseur+l_fixation_droite/2,-e_fixation_droite+epaisseur_ecrou_M4-3*chouilla,largeur/2+2*marge]) rotate([90,0,0]) ISO4032("M4");
      
    if(avec_rotule == 1)
    {   
      // Supprimer la matiere pour le passage de l'attache du haut avec une marge 
      ajustement_epassement = -0.5; 
      h_fixation_gauche_a_supprimer = 6;
      translate([-(d_int/2+epaisseur),ajustement_epassement-h_fixation_gauche+marge,e2_fixation_gauche]) cube([epaisseur+4*marge,h_fixation_gauche_a_supprimer+marge,e_fixation_gauche],center=false);


      // trou diam vis M4 pour vis de l'attache de gauche
      // Code identique au trou de la partie haute, juste modification de la   hauteur du cylindre, ici largeur
      translate([-(d_int/2+epaisseur/2)+ecartement_fixation_gauche,-h_fixation_gauche/2-ajustement_placement_trou_attache_gauche,largeur/2]) cylinder(h=largeur+10*chouilla, d=d_fixation_gauche+3*chouilla, center=true);
    
      // Trou pour une vis M4 sur l'attache de gauche
      translate([-(d_int/2+epaisseur/2)+ecartement_fixation_gauche,-h_fixation_gauche/2-ajustement_placement_trou_attache_gauche,largeur-epaisseur_ecrou_M4-1*chouilla]) ISO4032("M4"); 
      // Complement pour bien enlever toute la matière au niveau de la vis M4
      translate([-(d_int/2+epaisseur/2)+ecartement_fixation_gauche,-h_fixation_gauche/2-ajustement_placement_trou_attache_gauche,largeur-epaisseur_ecrou_M4+5*chouilla]) ISO4032("M4");         
        
    }
   
    if(avec_rotule == 1)
    {
      // Trou pour fixer le collier du bas sur une queue d'aronde
      trou_fixation_queue_aronde();
    }
 
  
  }
}




//------------------------------------------------------------------
// Barre d'attache du kickfinder de Rigel

epaisseur_dessous = 0;
epaisseur_barre = 11;
profondeur_int_barre = 2;
largeur_ext_barre = 41.05;
profondeur_ext_barre = 40.7;
largeur_int_barre = 36.1;
largeur_bord_barre = (largeur_ext_barre-largeur_int_barre)/2;

longeur_barre = 90;
//longeur_barre = profondeur_ext_barre;

largeur_grand_trou = 28.8;
largeur_petit_trou = 10.0;
hauteur_cote_petit_trou = 4.67;
espacement_trous = 24.6;
longeur_trou = 5.55;
profondeur_trou = 6.25;
hauteur_cote_grand_trou = profondeur_trou - 4.4;


module kick_finder_rigel()
{
      // Petit trou
      // 1- Supprimer matière par le dessus
     translate([-largeur_petit_trou/2,epaisseur_dessous+epaisseur_barre-profondeur_int_barre-profondeur_trou,largeur_bord_barre])  
        cube([largeur_petit_trou,profondeur_trou+1*marge,longeur_trou],center=false); 
        
      // 2 -Supprimer matière par le côté
     translate([-largeur_petit_trou/2,epaisseur_dessous+epaisseur_barre-profondeur_int_barre-profondeur_trou,-1*marge]) cube([largeur_petit_trou,hauteur_cote_petit_trou,largeur_bord_barre+1*marge],center=false);   
        
        
      // Grand trou
      // 4- Supprimer matière par le dessus
      // Idem 1, mais modifier la largeur et décaler en z de espacement_trous
     translate([-largeur_grand_trou/2,epaisseur_dessous+epaisseur_barre-profondeur_int_barre-profondeur_trou,largeur_bord_barre+longeur_trou+espacement_trous])  
        cube([largeur_grand_trou,profondeur_trou+1*marge,longeur_trou],center=false);       
        
      // Idem 2 mais pour le grand trou
    translate([-largeur_grand_trou/2,epaisseur_dessous+epaisseur_barre-profondeur_int_barre-profondeur_trou,profondeur_ext_barre-largeur_bord_barre-2*marge]) cube([largeur_grand_trou,hauteur_cote_grand_trou,largeur_bord_barre+5*marge],center=false);
}


module trou_fixation_barre(position)
{
    // Trou pour la vis
    translate([0,(epaisseur_dessous+epaisseur_barre)/2,position]) rotate([90,0,0]) cylinder(h=epaisseur_dessous+epaisseur_barre, d=d_fixation_centrale, center=true);
    // Trou pour la tête de vis
    translate([0,-profondeur_tete_vis_M4/2+epaisseur_dessous+epaisseur_barre-profondeur_int_barre-10*marge,position]) rotate([90,0,0]) cylinder(h=profondeur_tete_vis_M4, d=d_tete_vis_M4, center=true);   
    // Complement pour supprimer toute la matière du trou pour la tête de vis
    translate([0,-profondeur_tete_vis_M4/2+epaisseur_dessous+epaisseur_barre-profondeur_int_barre+1*marge,position]) rotate([90,0,0]) cylinder(h=profondeur_tete_vis_M4, d=d_tete_vis_M4, center=true); 
}


module barre()
{
  translate([0,0,0])
  {      
    difference()
    {
      // Barre principale
      translate([-largeur_ext_barre/2,0,0]) cube([largeur_ext_barre,epaisseur_barre+epaisseur_dessous,longeur_barre],center=false);
        
        
      // Supprimer matière sur le dessus
      translate([-largeur_int_barre/2,epaisseur_dessous+epaisseur_barre-profondeur_int_barre,largeur_bord_barre]) cube([largeur_int_barre,profondeur_int_barre+2*marge,longeur_barre-2*largeur_bord_barre],center=false); 
      
      // Supprimer matière sur le dessous
      translate([-base_dessus/2,-2*marge,-2*marge]) cube([base_dessus+1*marge,epaisseur_dessous+2*marge,longeur_barre+4*marge],center=false);

      if(grande_barre == 1)
      {       
        // Placement kickfinder Rigel
        translate([0,0,15])kick_finder_rigel();
        // Placement 2nd kickfinder Rigel
        translate([0,0,35]) kick_finder_rigel();    
      
    
        // Passage vis pour la fixation avec la base du dessus
        position1 = d_fixation_centrale/2+largeur/2;
        trou_fixation_barre(position1);
        // Idem, mais décalée depuis le haut de cette barre
        position2 = longeur_barre - position1;
        trou_fixation_barre(position2);   
      }
      else
      {
        // Placement kickfinder Rigel
        translate([0,0,0])kick_finder_rigel(); 
        
        // Passage vis pour la fixation avec la base du dessus 
        position1 = profondeur_ext_barre/2;
        trou_fixation_barre(position1);        
      }
        
    }
  }
}





    
    
    
    
