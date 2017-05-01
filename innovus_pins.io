( globals
   version = 3
   space=10
   io_order = default
)

(iopin
  (top 
		(pin name = HCLK       offset=40    layer=3    width=0.9    depth=0.9)
    		(pin name = HRESETn    offset=60    layer=3    width=0.9    depth=0.9)
    		(pin name = HSELx      offset=80    layer=3    width=0.9    depth=0.9)
    		(pin name = HBURST[2]  offset=100    layer=3    width=0.9    depth=0.9)
    		(pin name = HBURST[1]  offset=120    layer=3    width=0.9    depth=0.9)
    		(pin name = HBURST[0]  offset=140    layer=3    width=0.9    depth=0.9)
    		(pin name = HPROT[3]   offset=160    layer=3    width=0.9    depth=0.9)
    		(pin name = HPROT[2]   offset=180    layer=3    width=0.9    depth=0.9)
    		(pin name = HPROT[1]   offset=200    layer=3    width=0.9    depth=0.9)
    		(pin name = HPROT[0]   offset=220    layer=3    width=0.9    depth=0.9)
    		(pin name = HSIZE[2]   offset=240    layer=3    width=0.9    depth=0.9)
    		(pin name = HSIZE[1]   offset=260    layer=3    width=0.9    depth=0.9)
    		(pin name = HSIZE[0]   offset=280    layer=3    width=0.9    depth=0.9)
    		(pin name = HTRANS[1]  offset=300    layer=3    width=0.9    depth=0.9)
    		(pin name = HTRANS[0]  offset=320    layer=3    width=0.9    depth=0.9)
    		(pin name = HWRITE     offset=340    layer=3    width=0.9    depth=0.9)
  )
  (left
    (pin name = HADDR[31] offset=20    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[30] offset=30    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[29] offset=40    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[28] offset=50    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[27] offset=60    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[26] offset=70    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[25] offset=80    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[24] offset=90    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[23] offset=100    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[22] offset=110    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[21] offset=120    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[20] offset=130    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[19] offset=140    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[18] offset=150    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[17] offset=160    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[16] offset=170    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[15] offset=180    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[14] offset=190    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[13] offset=200    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[12] offset=210    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[11] offset=220    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[10] offset=230    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[9] offset=240    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[8] offset=250    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[7] offset=260    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[6] offset=270    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[5] offset=280    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[4] offset=290    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[3] offset=300    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[2] offset=310    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[1] offset=320    layer=3    width=0.9    depth=0.9)
    (pin name = HADDR[0] offset=330    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[31] offset=420    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[30] offset=430    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[29] offset=440    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[28] offset=450    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[27] offset=460    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[26] offset=470    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[25] offset=480    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[24] offset=490    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[23] offset=500    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[22] offset=510    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[21] offset=520    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[20] offset=530    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[19] offset=540    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[18] offset=550    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[17] offset=560    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[16] offset=570    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[15] offset=580    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[14] offset=590    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[13] offset=600    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[12] offset=610    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[11] offset=620    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[10] offset=630    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[9] offset=640    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[8] offset=650    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[7] offset=660    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[6] offset=670    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[5] offset=680    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[4] offset=690    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[3] offset=700    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[2] offset=710    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[1] offset=720    layer=3    width=0.9    depth=0.9)
    (pin name = HWDATA[0] offset=730    layer=3    width=0.9    depth=0.9)
  )
  (bottom
    (pin name = HRDATA[31] offset=20    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[30] offset=30    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[29] offset=40    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[28] offset=50    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[27] offset=60    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[26] offset=70    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[25] offset=80    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[24] offset=90    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[23] offset=100    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[22] offset=110    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[21] offset=120    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[20] offset=130    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[19] offset=140    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[18] offset=150    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[17] offset=160    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[16] offset=170    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[15] offset=180    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[14] offset=190    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[13] offset=200    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[12] offset=210    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[11] offset=220    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[10] offset=230    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[9] offset=240    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[8] offset=250    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[7] offset=260    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[6] offset=270    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[5] offset=280    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[4] offset=290    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[3] offset=300    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[2] offset=310    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[1] offset=320    layer=3    width=0.9    depth=0.9)
    (pin name = HRDATA[0] offset=330    layer=3    width=0.9    depth=0.9)
  )
  (right
    (pin name = HREADY    offset=40    layer=3    width=0.9    depth=0.9)
    (pin name = HRESP[1]   offset=60    layer=3    width=0.9    depth=0.9)
    (pin name = HRESP[0]   offset=80    layer=3    width=0.9    depth=0.9)
  )
)
