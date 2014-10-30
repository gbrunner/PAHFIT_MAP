

s0 = mrdfits('H28_map.fits',0, s0_header)
s1 = mrdfits('H17_map.fits',0, s1_header)
s2 = mrdfits('H12_map.fits',0, s2_header)                  
s3 = mrdfits('H9_map.fits',0, s3_header)
s4 = mrdfits('H8_map.fits',0, s4_header) 
s5 = mrdfits('H7_map.fits',0, s5_header) 
co = mrdfits('NC5194mom0h.fits', 0, co_header)

;FIX bad pixels
s2[0:30,0:9] = 0 
s3[0:30,0:9] = 0 
s4[0:30,0:9] = 0 
s5[0:30,0:9] = 0 

s2[29:30,173:174] = 0 
s3[29:30,173:174] = 0 
s4[29:30,173:174] = 0 
s5[29:30,173:174] = 0 

s2[25,147] = 0 
s3[25,147] = 0 
s4[25,147] = 0 
s5[25,147] = 0 

s2[0,153] = 0 
s3[0,153] = 0 
s4[0,153] = 0 
s5[0,153] = 0 

s2[22:23,155:156] = 0 
s3[22:23,155:156] = 0 
s4[22:23,155:156] = 0 
s5[22:23,155:156] = 0 

s2[15,154:155] = 0 
s3[15,154:155] = 0 
s4[15,154:155] = 0 
s5[15,154:155] = 0 

s2[20,168:169] = 0 
s3[20,168:169] = 0 
s4[20,168:169] = 0 
s5[20,168:169] = 0 

s2[19,167:168] = 0 
s3[19,167:168] = 0 
s4[19,167:168] = 0 
s5[19,167:168] = 0 

for i=0,n_elements(s0(*,0))-1,1 do begin
for j=0,n_elements(s0(0,*))-1,1 do begin

;print, i,j
if s0(i,j) LT 1.08457E-12 then s0(i,j)=1.08457E-12

endfor 
endfor

mwrfits, s0, 's0_rezero.fits', s0_header

for i=0,n_elements(s1(*,0))-1,1 do begin
for j=0,n_elements(s1(0,*))-1,1 do begin

if s1(i,j) LT 3.45392E-11 then s1(i,j)=3.45392E-11

endfor
endfor

mwrfits, s1, 's1_rezero.fits', s1_header

for i=0,n_elements(s2(*,0))-1,1 do begin
for j=0,n_elements(s2(0,*))-1,1 do begin

if s2(i,j) LT 1.45642E-12 then s2(i,j)=1.45642E-12

endfor
endfor

mwrfits, s2, 's2_rezero.fits', s2_header

for i=0,n_elements(s3(*,0))-1,1 do begin
for j=0,n_elements(s3(0,*))-1,1 do begin

if s3(i,j) LT 3.03597E-12 then s3(i,j)=3.03597E-12

endfor
endfor

mwrfits, s3, 's3_rezero.fits', s3_header

for i=0,n_elements(s4(*,0))-1,1 do begin
for j=0,n_elements(s4(0,*))-1,1 do begin

if s4(i,j) LT 1.55035e-12  then s4(i,j)=1.55035e-12

endfor
endfor

mwrfits, s4, 's4_rezero.fits', s4_header

for i=0,n_elements(s5(*,0))-1,1 do begin
for j=0,n_elements(s5(0,*))-1,1 do begin

if s5(i,j) LT 7.30594E-12 then s5(i,j)=7.30594E-12

endfor
endfor

mwrfits, s5, 's5_rezero.fits', s5_header

;s0_smooth = filter_image(s0, FWHM=1.5, /ALL_PIXELS)
;s1_smooth = filter_image(s1, FWHM=1.5, /ALL_PIXELS)
;s2_smooth = filter_image(s2, FWHM=2.75, /ALL_PIXELS)
;s3_smooth = filter_image(s3, FWHM=2.75, /ALL_PIXELS)
;s5_smooth = filter_image(s5, FWHM=2.75, /ALL_PIXELS)

;hastrom, s0, s0_header, s2_header, MISSING=0
;hastrom, s1, s1_header, s2_header, MISSING=0

;hastrom, s2, s2_header, s0_header, MISSING=0
;hastrom, s3, s3_header, s0_header, MISSING=0
;hastrom, s5, s5_header, s0_header, MISSING=0

end


s0_s1_ratio_map = s0_smooth/s1_smooth                                 
ln_factor = s0_s1_ratio_map*(47.6/2.95)*(28.219/17.035)*(21/5)
denom = alog(ln_factor)
t_map =(1682-510)/denom
mwrfits, t_map, 'H2_S0_S1_temp_map.fits', s0_header

;s1_s3_ratio_map = s1/s3_smooth                                
;ln_factor = s1_s3_ratio_map*(275/47.6)*(17.035/12.279)*(33/21)
;denom = alog(ln_factor)
;t_map =(2504-1015)/denom
;mwrfits, t_map, 'H2_S1_S3_temp_map.fits', s0_header
;mwrfits,s2,'s2.fits'           
      
s2_s3_ratio_map = s2_smooth/s3_smooth                                 
ln_factor = s2_s3_ratio_map*(980/275)*(12.279/9.665)*(33/9)
denom = alog(ln_factor)
t_map =(2503-1681)/denom
mwrfits, t_map, 'H2_S2_S3_temp_map.fits', s2_header

                                   
s3_s5_ratio_map = s3_smooth/s5_smooth            
ln_factor = s3_s5_ratio_map*(5880/980)*(9.665/6.910)*(45/33)
denom = alog(ln_factor)
t_map =(4585-2583)/denom
mwrfits, t_map, 'H2_S3_S5_temp_map.fits', s3_header

;mwrfits, s2_smooth, 'H12_smooth.fits', s2_header
;mwrfits, s3_smooth, 'H9_smooth.fits', s3_header
;mwrfits, s5_smooth, 'H7_smooth.fits', s5_header


end
