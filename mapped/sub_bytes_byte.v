/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 18 00:52:26 2017
/////////////////////////////////////////////////////////////


module sub_bytes_byte ( .l_table({\l_table[3][3][7] , \l_table[3][3][6] , 
        \l_table[3][3][5] , \l_table[3][3][4] , \l_table[3][3][3] , 
        \l_table[3][3][2] , \l_table[3][3][1] , \l_table[3][3][0] , 
        \l_table[3][2][7] , \l_table[3][2][6] , \l_table[3][2][5] , 
        \l_table[3][2][4] , \l_table[3][2][3] , \l_table[3][2][2] , 
        \l_table[3][2][1] , \l_table[3][2][0] , \l_table[3][1][7] , 
        \l_table[3][1][6] , \l_table[3][1][5] , \l_table[3][1][4] , 
        \l_table[3][1][3] , \l_table[3][1][2] , \l_table[3][1][1] , 
        \l_table[3][1][0] , \l_table[3][0][7] , \l_table[3][0][6] , 
        \l_table[3][0][5] , \l_table[3][0][4] , \l_table[3][0][3] , 
        \l_table[3][0][2] , \l_table[3][0][1] , \l_table[3][0][0] , 
        \l_table[2][3][7] , \l_table[2][3][6] , \l_table[2][3][5] , 
        \l_table[2][3][4] , \l_table[2][3][3] , \l_table[2][3][2] , 
        \l_table[2][3][1] , \l_table[2][3][0] , \l_table[2][2][7] , 
        \l_table[2][2][6] , \l_table[2][2][5] , \l_table[2][2][4] , 
        \l_table[2][2][3] , \l_table[2][2][2] , \l_table[2][2][1] , 
        \l_table[2][2][0] , \l_table[2][1][7] , \l_table[2][1][6] , 
        \l_table[2][1][5] , \l_table[2][1][4] , \l_table[2][1][3] , 
        \l_table[2][1][2] , \l_table[2][1][1] , \l_table[2][1][0] , 
        \l_table[2][0][7] , \l_table[2][0][6] , \l_table[2][0][5] , 
        \l_table[2][0][4] , \l_table[2][0][3] , \l_table[2][0][2] , 
        \l_table[2][0][1] , \l_table[2][0][0] , \l_table[1][3][7] , 
        \l_table[1][3][6] , \l_table[1][3][5] , \l_table[1][3][4] , 
        \l_table[1][3][3] , \l_table[1][3][2] , \l_table[1][3][1] , 
        \l_table[1][3][0] , \l_table[1][2][7] , \l_table[1][2][6] , 
        \l_table[1][2][5] , \l_table[1][2][4] , \l_table[1][2][3] , 
        \l_table[1][2][2] , \l_table[1][2][1] , \l_table[1][2][0] , 
        \l_table[1][1][7] , \l_table[1][1][6] , \l_table[1][1][5] , 
        \l_table[1][1][4] , \l_table[1][1][3] , \l_table[1][1][2] , 
        \l_table[1][1][1] , \l_table[1][1][0] , \l_table[1][0][7] , 
        \l_table[1][0][6] , \l_table[1][0][5] , \l_table[1][0][4] , 
        \l_table[1][0][3] , \l_table[1][0][2] , \l_table[1][0][1] , 
        \l_table[1][0][0] , \l_table[0][3][7] , \l_table[0][3][6] , 
        \l_table[0][3][5] , \l_table[0][3][4] , \l_table[0][3][3] , 
        \l_table[0][3][2] , \l_table[0][3][1] , \l_table[0][3][0] , 
        \l_table[0][2][7] , \l_table[0][2][6] , \l_table[0][2][5] , 
        \l_table[0][2][4] , \l_table[0][2][3] , \l_table[0][2][2] , 
        \l_table[0][2][1] , \l_table[0][2][0] , \l_table[0][1][7] , 
        \l_table[0][1][6] , \l_table[0][1][5] , \l_table[0][1][4] , 
        \l_table[0][1][3] , \l_table[0][1][2] , \l_table[0][1][1] , 
        \l_table[0][1][0] , \l_table[0][0][7] , \l_table[0][0][6] , 
        \l_table[0][0][5] , \l_table[0][0][4] , \l_table[0][0][3] , 
        \l_table[0][0][2] , \l_table[0][0][1] , \l_table[0][0][0] }), data_i, 
        data_o );
  input [7:0] data_i;
  output [7:0] data_o;
  input \l_table[3][3][7] , \l_table[3][3][6] , \l_table[3][3][5] ,
         \l_table[3][3][4] , \l_table[3][3][3] , \l_table[3][3][2] ,
         \l_table[3][3][1] , \l_table[3][3][0] , \l_table[3][2][7] ,
         \l_table[3][2][6] , \l_table[3][2][5] , \l_table[3][2][4] ,
         \l_table[3][2][3] , \l_table[3][2][2] , \l_table[3][2][1] ,
         \l_table[3][2][0] , \l_table[3][1][7] , \l_table[3][1][6] ,
         \l_table[3][1][5] , \l_table[3][1][4] , \l_table[3][1][3] ,
         \l_table[3][1][2] , \l_table[3][1][1] , \l_table[3][1][0] ,
         \l_table[3][0][7] , \l_table[3][0][6] , \l_table[3][0][5] ,
         \l_table[3][0][4] , \l_table[3][0][3] , \l_table[3][0][2] ,
         \l_table[3][0][1] , \l_table[3][0][0] , \l_table[2][3][7] ,
         \l_table[2][3][6] , \l_table[2][3][5] , \l_table[2][3][4] ,
         \l_table[2][3][3] , \l_table[2][3][2] , \l_table[2][3][1] ,
         \l_table[2][3][0] , \l_table[2][2][7] , \l_table[2][2][6] ,
         \l_table[2][2][5] , \l_table[2][2][4] , \l_table[2][2][3] ,
         \l_table[2][2][2] , \l_table[2][2][1] , \l_table[2][2][0] ,
         \l_table[2][1][7] , \l_table[2][1][6] , \l_table[2][1][5] ,
         \l_table[2][1][4] , \l_table[2][1][3] , \l_table[2][1][2] ,
         \l_table[2][1][1] , \l_table[2][1][0] , \l_table[2][0][7] ,
         \l_table[2][0][6] , \l_table[2][0][5] , \l_table[2][0][4] ,
         \l_table[2][0][3] , \l_table[2][0][2] , \l_table[2][0][1] ,
         \l_table[2][0][0] , \l_table[1][3][7] , \l_table[1][3][6] ,
         \l_table[1][3][5] , \l_table[1][3][4] , \l_table[1][3][3] ,
         \l_table[1][3][2] , \l_table[1][3][1] , \l_table[1][3][0] ,
         \l_table[1][2][7] , \l_table[1][2][6] , \l_table[1][2][5] ,
         \l_table[1][2][4] , \l_table[1][2][3] , \l_table[1][2][2] ,
         \l_table[1][2][1] , \l_table[1][2][0] , \l_table[1][1][7] ,
         \l_table[1][1][6] , \l_table[1][1][5] , \l_table[1][1][4] ,
         \l_table[1][1][3] , \l_table[1][1][2] , \l_table[1][1][1] ,
         \l_table[1][1][0] , \l_table[1][0][7] , \l_table[1][0][6] ,
         \l_table[1][0][5] , \l_table[1][0][4] , \l_table[1][0][3] ,
         \l_table[1][0][2] , \l_table[1][0][1] , \l_table[1][0][0] ,
         \l_table[0][3][7] , \l_table[0][3][6] , \l_table[0][3][5] ,
         \l_table[0][3][4] , \l_table[0][3][3] , \l_table[0][3][2] ,
         \l_table[0][3][1] , \l_table[0][3][0] , \l_table[0][2][7] ,
         \l_table[0][2][6] , \l_table[0][2][5] , \l_table[0][2][4] ,
         \l_table[0][2][3] , \l_table[0][2][2] , \l_table[0][2][1] ,
         \l_table[0][2][0] , \l_table[0][1][7] , \l_table[0][1][6] ,
         \l_table[0][1][5] , \l_table[0][1][4] , \l_table[0][1][3] ,
         \l_table[0][1][2] , \l_table[0][1][1] , \l_table[0][1][0] ,
         \l_table[0][0][7] , \l_table[0][0][6] , \l_table[0][0][5] ,
         \l_table[0][0][4] , \l_table[0][0][3] , \l_table[0][0][2] ,
         \l_table[0][0][1] , \l_table[0][0][0] ;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18,
         N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32,
         N33, N34, N35, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96;

  OR2X2 U1 ( .A(n73), .B(data_i[5]), .Y(n1) );
  OR2X2 U2 ( .A(n74), .B(data_i[4]), .Y(n2) );
  OR2X2 U3 ( .A(data_i[4]), .B(data_i[5]), .Y(n3) );
  INVX4 U4 ( .A(n2), .Y(n4) );
  INVX4 U5 ( .A(n3), .Y(n5) );
  INVX4 U6 ( .A(n1), .Y(n6) );
  BUFX2 U7 ( .A(n70), .Y(n7) );
  NOR2X1 U8 ( .A(n74), .B(n73), .Y(n70) );
  AOI22X1 U9 ( .A(\l_table[2][0][0] ), .B(n4), .C(\l_table[3][0][0] ), .D(n70), 
        .Y(n9) );
  AOI22X1 U10 ( .A(\l_table[0][0][0] ), .B(n5), .C(\l_table[1][0][0] ), .D(n6), 
        .Y(n8) );
  NAND2X1 U11 ( .A(n9), .B(n8), .Y(N35) );
  AOI22X1 U12 ( .A(\l_table[2][0][1] ), .B(n4), .C(\l_table[3][0][1] ), .D(n70), .Y(n11) );
  AOI22X1 U13 ( .A(\l_table[0][0][1] ), .B(n5), .C(\l_table[1][0][1] ), .D(n6), 
        .Y(n10) );
  NAND2X1 U14 ( .A(n11), .B(n10), .Y(N34) );
  AOI22X1 U15 ( .A(\l_table[2][0][2] ), .B(n4), .C(\l_table[3][0][2] ), .D(n70), .Y(n13) );
  AOI22X1 U16 ( .A(\l_table[0][0][2] ), .B(n5), .C(\l_table[1][0][2] ), .D(n6), 
        .Y(n12) );
  NAND2X1 U17 ( .A(n13), .B(n12), .Y(N33) );
  AOI22X1 U18 ( .A(\l_table[2][0][3] ), .B(n4), .C(\l_table[3][0][3] ), .D(n70), .Y(n15) );
  AOI22X1 U19 ( .A(\l_table[0][0][3] ), .B(n5), .C(\l_table[1][0][3] ), .D(n6), 
        .Y(n14) );
  NAND2X1 U20 ( .A(n15), .B(n14), .Y(N32) );
  AOI22X1 U21 ( .A(\l_table[2][0][4] ), .B(n4), .C(\l_table[3][0][4] ), .D(n70), .Y(n17) );
  AOI22X1 U22 ( .A(\l_table[0][0][4] ), .B(n5), .C(\l_table[1][0][4] ), .D(n6), 
        .Y(n16) );
  NAND2X1 U23 ( .A(n17), .B(n16), .Y(N31) );
  AOI22X1 U24 ( .A(\l_table[2][0][5] ), .B(n4), .C(\l_table[3][0][5] ), .D(n70), .Y(n19) );
  AOI22X1 U25 ( .A(\l_table[0][0][5] ), .B(n5), .C(\l_table[1][0][5] ), .D(n6), 
        .Y(n18) );
  NAND2X1 U26 ( .A(n19), .B(n18), .Y(N30) );
  AOI22X1 U27 ( .A(\l_table[2][0][6] ), .B(n4), .C(\l_table[3][0][6] ), .D(n70), .Y(n21) );
  AOI22X1 U28 ( .A(\l_table[0][0][6] ), .B(n5), .C(\l_table[1][0][6] ), .D(n6), 
        .Y(n20) );
  NAND2X1 U29 ( .A(n21), .B(n20), .Y(N29) );
  AOI22X1 U30 ( .A(\l_table[2][0][7] ), .B(n4), .C(\l_table[3][0][7] ), .D(n70), .Y(n23) );
  AOI22X1 U31 ( .A(\l_table[0][0][7] ), .B(n5), .C(\l_table[1][0][7] ), .D(n6), 
        .Y(n22) );
  NAND2X1 U32 ( .A(n23), .B(n22), .Y(N28) );
  AOI22X1 U33 ( .A(\l_table[2][1][0] ), .B(n4), .C(\l_table[3][1][0] ), .D(n70), .Y(n25) );
  AOI22X1 U34 ( .A(\l_table[0][1][0] ), .B(n5), .C(\l_table[1][1][0] ), .D(n6), 
        .Y(n24) );
  NAND2X1 U35 ( .A(n25), .B(n24), .Y(N27) );
  AOI22X1 U36 ( .A(\l_table[2][1][1] ), .B(n4), .C(\l_table[3][1][1] ), .D(n70), .Y(n27) );
  AOI22X1 U37 ( .A(\l_table[0][1][1] ), .B(n5), .C(\l_table[1][1][1] ), .D(n6), 
        .Y(n26) );
  NAND2X1 U38 ( .A(n27), .B(n26), .Y(N26) );
  AOI22X1 U39 ( .A(\l_table[2][1][2] ), .B(n4), .C(\l_table[3][1][2] ), .D(n70), .Y(n29) );
  AOI22X1 U40 ( .A(\l_table[0][1][2] ), .B(n5), .C(\l_table[1][1][2] ), .D(n6), 
        .Y(n28) );
  NAND2X1 U41 ( .A(n29), .B(n28), .Y(N25) );
  AOI22X1 U42 ( .A(\l_table[2][1][3] ), .B(n4), .C(\l_table[3][1][3] ), .D(n7), 
        .Y(n31) );
  AOI22X1 U43 ( .A(\l_table[0][1][3] ), .B(n5), .C(\l_table[1][1][3] ), .D(n6), 
        .Y(n30) );
  NAND2X1 U44 ( .A(n31), .B(n30), .Y(N24) );
  AOI22X1 U45 ( .A(\l_table[2][1][4] ), .B(n4), .C(\l_table[3][1][4] ), .D(n7), 
        .Y(n33) );
  AOI22X1 U46 ( .A(\l_table[0][1][4] ), .B(n5), .C(\l_table[1][1][4] ), .D(n6), 
        .Y(n32) );
  NAND2X1 U47 ( .A(n33), .B(n32), .Y(N23) );
  AOI22X1 U48 ( .A(\l_table[2][1][5] ), .B(n4), .C(\l_table[3][1][5] ), .D(n7), 
        .Y(n35) );
  AOI22X1 U49 ( .A(\l_table[0][1][5] ), .B(n5), .C(\l_table[1][1][5] ), .D(n6), 
        .Y(n34) );
  NAND2X1 U50 ( .A(n35), .B(n34), .Y(N22) );
  AOI22X1 U51 ( .A(\l_table[2][1][6] ), .B(n4), .C(\l_table[3][1][6] ), .D(n7), 
        .Y(n37) );
  AOI22X1 U52 ( .A(\l_table[0][1][6] ), .B(n5), .C(\l_table[1][1][6] ), .D(n6), 
        .Y(n36) );
  NAND2X1 U53 ( .A(n37), .B(n36), .Y(N21) );
  AOI22X1 U54 ( .A(\l_table[2][1][7] ), .B(n4), .C(\l_table[3][1][7] ), .D(n7), 
        .Y(n39) );
  AOI22X1 U55 ( .A(\l_table[0][1][7] ), .B(n5), .C(\l_table[1][1][7] ), .D(n6), 
        .Y(n38) );
  NAND2X1 U56 ( .A(n39), .B(n38), .Y(N20) );
  AOI22X1 U57 ( .A(\l_table[2][2][0] ), .B(n4), .C(\l_table[3][2][0] ), .D(n7), 
        .Y(n41) );
  AOI22X1 U58 ( .A(\l_table[0][2][0] ), .B(n5), .C(\l_table[1][2][0] ), .D(n6), 
        .Y(n40) );
  NAND2X1 U59 ( .A(n41), .B(n40), .Y(N19) );
  AOI22X1 U60 ( .A(\l_table[2][2][1] ), .B(n4), .C(\l_table[3][2][1] ), .D(n7), 
        .Y(n43) );
  AOI22X1 U61 ( .A(\l_table[0][2][1] ), .B(n5), .C(\l_table[1][2][1] ), .D(n6), 
        .Y(n42) );
  NAND2X1 U62 ( .A(n43), .B(n42), .Y(N18) );
  AOI22X1 U63 ( .A(\l_table[2][2][2] ), .B(n4), .C(\l_table[3][2][2] ), .D(n7), 
        .Y(n45) );
  AOI22X1 U64 ( .A(\l_table[0][2][2] ), .B(n5), .C(\l_table[1][2][2] ), .D(n6), 
        .Y(n44) );
  NAND2X1 U65 ( .A(n45), .B(n44), .Y(N17) );
  AOI22X1 U66 ( .A(\l_table[2][2][3] ), .B(n4), .C(\l_table[3][2][3] ), .D(n7), 
        .Y(n47) );
  AOI22X1 U67 ( .A(\l_table[0][2][3] ), .B(n5), .C(\l_table[1][2][3] ), .D(n6), 
        .Y(n46) );
  NAND2X1 U68 ( .A(n47), .B(n46), .Y(N16) );
  AOI22X1 U69 ( .A(\l_table[2][2][4] ), .B(n4), .C(\l_table[3][2][4] ), .D(n7), 
        .Y(n49) );
  AOI22X1 U70 ( .A(\l_table[0][2][4] ), .B(n5), .C(\l_table[1][2][4] ), .D(n6), 
        .Y(n48) );
  NAND2X1 U71 ( .A(n49), .B(n48), .Y(N15) );
  AOI22X1 U72 ( .A(\l_table[2][2][5] ), .B(n4), .C(\l_table[3][2][5] ), .D(n7), 
        .Y(n51) );
  AOI22X1 U73 ( .A(\l_table[0][2][5] ), .B(n5), .C(\l_table[1][2][5] ), .D(n6), 
        .Y(n50) );
  NAND2X1 U74 ( .A(n51), .B(n50), .Y(N14) );
  AOI22X1 U75 ( .A(\l_table[2][2][6] ), .B(n4), .C(\l_table[3][2][6] ), .D(n7), 
        .Y(n53) );
  AOI22X1 U76 ( .A(\l_table[0][2][6] ), .B(n5), .C(\l_table[1][2][6] ), .D(n6), 
        .Y(n52) );
  NAND2X1 U77 ( .A(n53), .B(n52), .Y(N13) );
  AOI22X1 U78 ( .A(\l_table[2][2][7] ), .B(n4), .C(\l_table[3][2][7] ), .D(n7), 
        .Y(n55) );
  AOI22X1 U79 ( .A(\l_table[0][2][7] ), .B(n5), .C(\l_table[1][2][7] ), .D(n6), 
        .Y(n54) );
  NAND2X1 U80 ( .A(n55), .B(n54), .Y(N12) );
  AOI22X1 U81 ( .A(\l_table[2][3][0] ), .B(n4), .C(\l_table[3][3][0] ), .D(n7), 
        .Y(n57) );
  AOI22X1 U82 ( .A(\l_table[0][3][0] ), .B(n5), .C(\l_table[1][3][0] ), .D(n6), 
        .Y(n56) );
  NAND2X1 U83 ( .A(n57), .B(n56), .Y(N11) );
  AOI22X1 U84 ( .A(\l_table[2][3][1] ), .B(n4), .C(\l_table[3][3][1] ), .D(n7), 
        .Y(n59) );
  AOI22X1 U85 ( .A(\l_table[0][3][1] ), .B(n5), .C(\l_table[1][3][1] ), .D(n6), 
        .Y(n58) );
  NAND2X1 U86 ( .A(n59), .B(n58), .Y(N10) );
  AOI22X1 U87 ( .A(\l_table[2][3][2] ), .B(n4), .C(\l_table[3][3][2] ), .D(n7), 
        .Y(n61) );
  AOI22X1 U88 ( .A(\l_table[0][3][2] ), .B(n5), .C(\l_table[1][3][2] ), .D(n6), 
        .Y(n60) );
  NAND2X1 U89 ( .A(n61), .B(n60), .Y(N9) );
  AOI22X1 U90 ( .A(\l_table[2][3][3] ), .B(n4), .C(\l_table[3][3][3] ), .D(n7), 
        .Y(n63) );
  AOI22X1 U91 ( .A(\l_table[0][3][3] ), .B(n5), .C(\l_table[1][3][3] ), .D(n6), 
        .Y(n62) );
  NAND2X1 U92 ( .A(n63), .B(n62), .Y(N8) );
  AOI22X1 U93 ( .A(\l_table[2][3][4] ), .B(n4), .C(\l_table[3][3][4] ), .D(n7), 
        .Y(n65) );
  AOI22X1 U94 ( .A(\l_table[0][3][4] ), .B(n5), .C(\l_table[1][3][4] ), .D(n6), 
        .Y(n64) );
  NAND2X1 U95 ( .A(n65), .B(n64), .Y(N7) );
  AOI22X1 U96 ( .A(\l_table[2][3][5] ), .B(n4), .C(\l_table[3][3][5] ), .D(n7), 
        .Y(n67) );
  AOI22X1 U97 ( .A(\l_table[0][3][5] ), .B(n5), .C(\l_table[1][3][5] ), .D(n6), 
        .Y(n66) );
  NAND2X1 U98 ( .A(n67), .B(n66), .Y(N6) );
  AOI22X1 U99 ( .A(\l_table[2][3][6] ), .B(n4), .C(\l_table[3][3][6] ), .D(n7), 
        .Y(n69) );
  AOI22X1 U100 ( .A(\l_table[0][3][6] ), .B(n5), .C(\l_table[1][3][6] ), .D(n6), .Y(n68) );
  NAND2X1 U101 ( .A(n69), .B(n68), .Y(N5) );
  AOI22X1 U102 ( .A(\l_table[2][3][7] ), .B(n4), .C(\l_table[3][3][7] ), .D(n7), .Y(n72) );
  AOI22X1 U103 ( .A(\l_table[0][3][7] ), .B(n5), .C(\l_table[1][3][7] ), .D(n6), .Y(n71) );
  NAND2X1 U104 ( .A(n72), .B(n71), .Y(N4) );
  INVX2 U105 ( .A(data_i[4]), .Y(n73) );
  INVX2 U106 ( .A(data_i[5]), .Y(n74) );
  NOR2X1 U107 ( .A(n96), .B(data_i[0]), .Y(n90) );
  NOR2X1 U108 ( .A(n96), .B(n95), .Y(n89) );
  AOI22X1 U109 ( .A(N19), .B(n90), .C(N11), .D(n89), .Y(n76) );
  NOR2X1 U110 ( .A(data_i[0]), .B(data_i[1]), .Y(n92) );
  NOR2X1 U111 ( .A(n95), .B(data_i[1]), .Y(n91) );
  AOI22X1 U112 ( .A(N35), .B(n92), .C(N27), .D(n91), .Y(n75) );
  NAND2X1 U113 ( .A(n76), .B(n75), .Y(data_o[0]) );
  AOI22X1 U114 ( .A(N18), .B(n90), .C(N10), .D(n89), .Y(n78) );
  AOI22X1 U115 ( .A(N34), .B(n92), .C(N26), .D(n91), .Y(n77) );
  NAND2X1 U116 ( .A(n78), .B(n77), .Y(data_o[1]) );
  AOI22X1 U117 ( .A(N17), .B(n90), .C(N9), .D(n89), .Y(n80) );
  AOI22X1 U118 ( .A(N33), .B(n92), .C(N25), .D(n91), .Y(n79) );
  NAND2X1 U119 ( .A(n80), .B(n79), .Y(data_o[2]) );
  AOI22X1 U120 ( .A(N16), .B(n90), .C(N8), .D(n89), .Y(n82) );
  AOI22X1 U121 ( .A(N32), .B(n92), .C(N24), .D(n91), .Y(n81) );
  NAND2X1 U122 ( .A(n82), .B(n81), .Y(data_o[3]) );
  AOI22X1 U123 ( .A(N15), .B(n90), .C(N7), .D(n89), .Y(n84) );
  AOI22X1 U124 ( .A(N31), .B(n92), .C(N23), .D(n91), .Y(n83) );
  NAND2X1 U125 ( .A(n84), .B(n83), .Y(data_o[4]) );
  AOI22X1 U126 ( .A(N14), .B(n90), .C(N6), .D(n89), .Y(n86) );
  AOI22X1 U127 ( .A(N30), .B(n92), .C(N22), .D(n91), .Y(n85) );
  NAND2X1 U128 ( .A(n86), .B(n85), .Y(data_o[5]) );
  AOI22X1 U129 ( .A(N13), .B(n90), .C(N5), .D(n89), .Y(n88) );
  AOI22X1 U130 ( .A(N29), .B(n92), .C(N21), .D(n91), .Y(n87) );
  NAND2X1 U131 ( .A(n88), .B(n87), .Y(data_o[6]) );
  AOI22X1 U132 ( .A(N12), .B(n90), .C(N4), .D(n89), .Y(n94) );
  AOI22X1 U133 ( .A(N28), .B(n92), .C(N20), .D(n91), .Y(n93) );
  NAND2X1 U134 ( .A(n94), .B(n93), .Y(data_o[7]) );
  INVX2 U135 ( .A(data_i[0]), .Y(n95) );
  INVX2 U136 ( .A(data_i[1]), .Y(n96) );
endmodule

