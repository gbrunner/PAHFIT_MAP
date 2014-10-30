
pro ll_pahfitmap, ll_cube, ll_unc, ll1_wave_tbl, ll2_wave_tbl, z=redshift

;Read in cubes
;SL cubes concatonated in LL_CUBE_JOIN.PRO
ll_cube = mrdfits(ll_cube, 0, ll_cube_header)
ll_unc = mrdfits(ll_unc, 0, ll_cube_header)

;Redshift
z=redshift    ;cz in km/s

;Whole Cube
;FOR M51a DATA
ll1_cube = ll_cube[39:140, 1:9, 75:173]
ll1_unc =  ll_unc[39:140, 1:9, 75:173]
ll2_cube = ll_cube[39:140, 1:9, 0:74]
ll2_unc = ll_unc[39:140, 1:9, 0:74]

;Read in Wavelength files
readcol, ll1_wave_tbl, ll1_wave, ll1_junk1, ll1_junk2
readcol, ll2_wave_tbl, ll2_wave, ll2_junk1, ll2_junk2

;Truncate wavelength just as we did the cubes
ll1_wave = ll1_wave[0:98]
ll2_wave = ll2_wave[0:74]

;stack cubes and wavelength

;ll_cube = [[[ll2_cube]], [[ll1_cube]]]
;ll_unc  = [[[ll2_unc]], [[ll1_unc]]]
ll_wave = [ll2_wave, ll1_wave]
wave    = ll_wave

;___________________________________________
;LL cube joining algorithm

x = n_elements(ll1_cube(*,0,0))-1
y = n_elements(ll1_cube(0,*,0))-1

for i=0,x,1 do begin
for j=0,y,1 do begin

med_ll1 = median(ll1_cube(i,j,0:8))
med_ll1 = median(ll1_cube(i,j,0:8))

med_ll2 = median(ll2_cube(i,j,66:74))
med_ll2 = median(ll2_cube(i,j,66:74))

scale = med_ll1 - med_ll2

ll2_cube[i,j,*] = ll2_cube[i,j,*] + scale

endfor
endfor

;_____________________________________________

ll_cube = [[[ll2_cube]], [[ll1_cube]]]
ll_unc  = [[[ll2_unc]], [[ll1_unc]]]

old_cube = ll_cube
old_unc = ll_unc

new_cube = ll_cube
new_unc = ll_unc

x = n_elements(ll_cube(*,0,0))-1
y = n_elements(ll_cube(0,*,0))-1
z = n_elements(ll_cube(0,0,*))-1

x_crop = n_elements(ll_cube(*,0,0))-2
y_crop = n_elements(ll_cube(0,*,0))-2
z_crop = n_elements(ll_cube(0,0,*))-2

for i=1,x_crop,1 do begin
for j=1,y_crop,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i+1,j+1,*)+ll_cube(i-1,j-1,*)+ll_cube(i-1,j+1,*)+ll_cube(i+1,j-1,*)+ll_cube(i,j+1,*)+ll_cube(i,j-1,*)+ll_cube(i+1,j,*)+ll_cube(i-1,j,*))/9

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i+1,j+1,*)+ll_unc(i-1,j-1,*)+ll_unc(i-1,j+1,*)+ll_unc(i+1,j-1,*)+ll_unc(i,j+1,*)+ll_unc(i,j-1,*)+ll_unc(i+1,j,*)+ll_unc(i-1,j,*))/9

endfor
endfor

for i=0,0,1 do begin
for j=1,y_crop, 1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i+1,j+1,*)+ll_cube(i+1,j-1,*)+ll_cube(i,j+1,*)+ll_cube(i,j-1,*)+ll_cube(i+1,j,*))/6

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i+1,j+1,*)+ll_unc(i+1,j-1,*)+ll_unc(i,j+1,*)+ll_unc(i,j-1,*)+ll_unc(i+1,j,*))/6

endfor
endfor

for i=x,x,1 do begin
for j=1,y_crop,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i-1,j-1,*)+ll_cube(i-1,j+1,*)+ll_cube(i,j+1,*)+ll_cube(i,j-1,*)+ll_cube(i-1,j,*))/6

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i-1,j-1,*)+ll_unc(i-1,j+1,*)+ll_unc(i,j+1,*)+ll_unc(i,j-1,*)+ll_unc(i-1,j,*))/6

endfor
endfor

for j=0,0,1 do begin
for i=1,x_crop,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i+1,j+1,*)+ll_cube(i-1,j+1,*)+ll_cube(i,j+1,*)+ll_cube(i+1,j,*)+ll_cube(i-1,j,*))/6

new_unc(i,j,*) =  (ll_unc(i,j,*)+ll_unc(i+1,j+1,*)+ll_unc(i-1,j+1,*)+ll_unc(i,j+1,*)+ll_unc(i+1,j,*)+ll_unc(i-1,j,*))/6

endfor
endfor


for j=y,y,1 do begin
for i=1,x_crop,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i-1,j-1,*)+ll_cube(i+1,j-1,*)+ll_cube(i,j-1,*)+ll_cube(i+1,j,*)+ll_cube(i-1,j,*))/6

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i-1,j-1,*)+ll_unc(i+1,j-1,*)+ll_unc(i,j-1,*)+ll_unc(i+1,j,*)+ll_unc(i-1,j,*))/6

endfor
endfor

for j=0,0,1 do begin
for i=0,0,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i+1,j+1,*)+ll_cube(i,j+1,*)+ll_cube(i+1,j,*))/4

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i+1,j+1,*)+ll_unc(i,j+1,*)+ll_unc(i+1,j,*))/4

endfor
endfor

for j=0,0,1 do begin
for i=x,x,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i-1,j+1,*)+ll_cube(i,j+1,*)+ll_cube(i-1,j,*))/4

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i-1,j+1,*)+ll_unc(i,j+1,*)+ll_unc(i-1,j,*))/4

endfor
endfor

for j=y,y,1 do begin
for i=0,0,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i+1,j-1,*)+ll_cube(i,j-1,*)+ll_cube(i+1,j,*))/4

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i+1,j-1,*)+ll_unc(i,j-1,*)+ll_unc(i+1,j,*))/4

endfor
endfor

for j=y,y,1 do begin
for i=x,x,1 do begin

new_cube(i,j,*) = (ll_cube(i,j,*)+ll_cube(i-1,j-1,*)+ll_cube(i,j-1,*)+ll_cube(i-1,j,*))/4

new_unc(i,j,*) = (ll_unc(i,j,*)+ll_unc(i-1,j-1,*)+ll_unc(i,j-1,*)+ll_unc(i-1,j,*))/4

endfor
endfor

ll_cube = new_cube
ll_unc = new_unc

;Initialize PAHFIT cube
fit_cube = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)), n_elements(wave))
cont_fit = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)), n_elements(wave))

;Initialize ionization maps 
SiII     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
SIII33   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
H_28     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
FeII     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
OIV      = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
SIII18   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
H_17     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
NeIII    = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Line FWHMs
SiII_fwhm     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
SIII33_fwhm   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
H_28_fwhm     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
FeII_fwhm     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
OIV_fwhm      = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
SIII18_fwhm   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
H_17_fwhm     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
NeIII_fwhm    = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Initialize EW maps
ew_SiII     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
ew_SIII33   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
ew_H_28     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
ew_FeII     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
ew_OIV      = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
ew_SIII18   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
ew_H_17     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
ew_NeIII    = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Initialize uncertainty arrays
SiII_unc     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
SIII33_unc   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
H_28_unc     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
FeII_unc     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
OIV_unc      = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
SIII18_unc   = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
H_17_unc     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
NeIII_unc    = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Initialize Dust Feature Arrays
df_33_1_micron  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_18_9_micron  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_87_micron = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_38_micron = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_micron    = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_16_5_micron  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_15_9_micron  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Dust Feature FWHMs
df_33_1_micron_fwhm  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_18_9_micron_fwhm  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_87_micron_fwhm = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_38_micron_fwhm = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_micron_fwhm    = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_16_5_micron_fwhm  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_15_9_micron_fwhm  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Initialize Dust Feature Uncertainty Arrays
df_33_1_micron_unc  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_18_9_micron_unc  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_87_micron_unc = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_17_38_micron_unc = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0))) 
df_17_micron_unc    = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_16_5_micron_unc  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
df_15_9_micron_unc  = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Initialize Chi Squared Array
chi_sq = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Initialize beta
beta_pahfit     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
beta_unc_pahfit = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

;Initialize tau 9.7 
tau_9_7_pahfit     = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))
tau_9_7_unc_pahfit = fltarr(n_elements(ll_cube(*,0,0)), n_elements(ll_cube(0,*,0)))

for i=0,x,1 do begin
for j=0,y,1 do begin

;Empty parinfo
fake_fit=pahfit(wave, ll_cube(i,j,*),parinfo=parinfo_init, /NO_FIX, REDSHIFT=z, /NO_FIT)

parinfo_pass = parinfo_init

init_fit=pahfit(wave, ll_cube(i,j,*), ll_unc(i,j,*), parinfo=parinfo_pass, REDSHIFT=z)

parinfo_use = parinfo_pass

fit=pahfit(wave, ll_cube(i,j,*), ll_unc(i,j,*), parinfo=parinfo_use, REDSHIFT=z);, /PLOT_PROGRESS)

print, "i = ", i
print, "j = ", j

fit_cube[i,j,*]    = fit.final_fit
line_strengths     = fit.lines.int_strength
line_strengths_unc = fit.lines.int_strength_unc
line_fwhm          = fit.lines.fwhm 
ew                 = fit.lines.eqw
dust_feature       = fit.dust_features.int_strength
dust_feature_unc   = fit.dust_features.int_strength_unc
dust_feature_fwhm  = fit.dust_features.fwhm
chi_squared        = fit.reduced_chi_sq
beta               = fit.extinction.beta
beta_unc           = fit.extinction.beta_unc
tau_9_7            = fit.extinction.tau_9_7
tau_9_7_unc        = fit.extinction.tau_9_7_unc

;Reconstruct the continuum fit 
stars   = fit.starlight.tau*pahfit_blackbody_nu(wave, fit.starlight.temperature)
dc_pars = fit.dust_continuum
for k=0,n_elements(dc_pars)-1 do begin
    this_dc = dc_pars[k].tau*(9.7D/wave)^2* $
              pahfit_blackbody_nu(wave,dc_pars[k].temperature)
    if k eq 0 then dc_tot=this_dc else dc_tot+=this_dc
endfor
tot_cont = dc_tot+stars
continuum_fit =tot_cont

extinction = pahfit_tau(wave,fit.extinction.beta, $
                          CHIAR_TIELENS=fit.extinction.type eq 1, $
                          KEMPER_VRIEND_TIELENS=fit.extinction.type eq 0)

ext=pahfit_extinction(wave,fit.extinction.tau_9_7,extinction, $
                        SCREEN=fit.extinction.screen)

continuum_fit = ext*continuum_fit
;plot, wave, fit.final_fit/wave, xrange=[10,35]
;oplot, wave, continuum_fit/wave
cont_fit[i,j,*]   = continuum_fit

;Line strength arrays
SiII[i,j]   = line_strengths[17]
SIII33[i,j] = line_strengths[16]
H_28[i,j]   = line_strengths[15]
FeII[i,j]   = line_strengths[14]
OIV[i,j]    = line_strengths[13]
SIII18[i,j] = line_strengths[12]
H_17[i,j]   = line_strengths[11]
NeIII[i,j]  = line_strengths[10]

;Line FWHMs
SiII_fwhm[i,j]   = line_fwhm[17]
SIII33_fwhm[i,j] = line_fwhm[16]
H_28_fwhm[i,j]   = line_fwhm[15]
FeII_fwhm[i,j]   = line_fwhm[14]
OIV_fwhm[i,j]    = line_fwhm[13]
SIII18_fwhm[i,j] = line_fwhm[12]
H_17_fwhm[i,j]   = line_fwhm[11]
NeIII_fwhm[i,j]  = line_fwhm[10]

;EW arrays
ew_SiII[i,j]   = ew[17]
ew_SIII33[i,j] = ew[16]
ew_H_28[i,j]   = ew[15]
ew_FeII[i,j]   = ew[14]
ew_OIV[i,j]    = ew[13]
ew_SIII18[i,j] = ew[12]
ew_H_17[i,j]   = ew[11]
ew_NeIII[i,j]  = ew[10]

;Uncertainty arrays
SiII_unc[i,j]   = line_strengths_unc[17]
SIII33_unc[i,j] = line_strengths_unc[16]
H_28_unc[i,j]   = line_strengths_unc[15]
FeII_unc[i,j]   = line_strengths_unc[14]
OIV_unc[i,j]    = line_strengths_unc[13]
SIII18_unc[i,j] = line_strengths_unc[12]
H_17_unc[i,j]   = line_strengths_unc[11]
NeIII_unc[i,j]  = line_strengths_unc[10]

;Dust Features
df_33_1_micron[i,j]  = dust_feature[24]
df_18_9_micron[i,j]  = dust_feature[23]
df_17_87_micron[i,j] = dust_feature[22]
df_17_38_micron[i,j] = dust_feature[21]
df_17_micron[i,j]    = dust_feature[20]
df_16_5_micron[i,j]  = dust_feature[19]
df_15_9_micron[i,j]  = dust_feature[18]

;Dust FWHMs
df_33_1_micron_fwhm[i,j] = dust_feature_fwhm[24]
df_18_9_micron_fwhm[i,j] = dust_feature_fwhm[23]
df_17_87_micron_fwhm[i,j]= dust_feature_fwhm[22]
df_17_38_micron_fwhm[i,j]= dust_feature_fwhm[21]
df_17_micron_fwhm[i,j]   = dust_feature_fwhm[20]
df_16_5_micron_fwhm[i,j] = dust_feature_fwhm[19]
df_15_9_micron_fwhm[i,j] = dust_feature_fwhm[18]

;Dust Feature Uncertainties
df_33_1_micron_unc[i,j]  = dust_feature_unc[24]
df_18_9_micron_unc[i,j]  = dust_feature_unc[23]
df_17_87_micron_unc[i,j] = dust_feature_unc[22]
df_17_38_micron_unc[i,j] = dust_feature_unc[21]
df_17_micron_unc[i,j]    = dust_feature_unc[20]
df_16_5_micron_unc[i,j]  = dust_feature_unc[19]
df_15_9_micron_unc[i,j]  = dust_feature_unc[18]

;Chi Squared
chi_sq[i,j] = chi_squared

;Beta
beta_pahfit[i,j]     = beta
beta_unc_pahfit[i,j] = beta_unc

;Tau 9.7
tau_9_7_pahfit[i,j]     = tau_9_7
tau_9_7_unc_pahfit[i,j] = tau_9_7_unc


endfor
endfor

;End all for loops!

;WRITE ARRAYS TO FITS FILES

;Update Headers
;Edit header info
ll_crpix1_p = sxpar(ll_cube_header, 'CRPIX1') ;Ref pix x
ll_crpix2_p = sxpar(ll_cube_header, 'CRPIX2') ;Ref pix y
ll_cdelt1_p = sxpar(ll_cube_header, 'CDELT1') ;Degree/Pix
ll_cdelt2_p = sxpar(ll_cube_header, 'CDELT2') ;Degree/Pix
ll_crval1_p = sxpar(ll_cube_header, 'CRVAL1') ;RA
ll_crval2_p = sxpar(ll_cube_header, 'CRVAL2') ;Dec

ll_crpix1 = ll_crpix1_p - 39
ll_crpix2 = ll_crpix2_p - 1
ll_cdelt1 = ll_cdelt1_p
ll_cdelt2 = ll_cdelt2_p
ll_crval1 = ll_crval1_p
ll_crval2 = ll_crval2_p

;Cube Headers
hist = strarr(4)
hist[0] = 'PAHMAP'
hist[1] = 'This file was produced by running pahfit.pro' 
hist[2] = 'over the joined LL IRS Spectral Cubes'
hist[3] = 'This is the PAHFIT CUBE'
sxaddhist, hist, ll_cube_header
sxdelpar, ll_cube_header, ['CRPIX1']
sxdelpar, ll_cube_header, ['CRPIX2']
sxdelpar, ll_cube_header, ['CRVAL1']
sxdelpar, ll_cube_header, ['CRVAL2']
sxdelpar, ll_cube_header, ['CDELT1']
sxdelpar, ll_cube_header, ['CDELT2']
sxaddpar, ll_cube_header, 'CRPIX1', ll_crpix1
sxaddpar, ll_cube_header, 'CRPIX2', ll_crpix2
sxaddpar, ll_cube_header, 'CRVAL1', ll_crval1
sxaddpar, ll_cube_header, 'CRVAL2', ll_crval2
sxaddpar, ll_cube_header, 'CDELT1', ll_cdelt1
sxaddpar, ll_cube_header, 'CDELT2', ll_cdelt2

;Map Headers
ll_header = ll_cube_header
map_hist = strarr(4)
map_hist[0] = 'PAHMAP'
map_hist[1] = 'This file was produced by running pahfit.pro' 
map_hist[2] = 'over the joined LL IRS Spectral Cubes'
map_hist[3] = 'This is the PAHFIT FEATURE MAP'
sxaddhist, map_hist, ll_header
sxdelpar, ll_header, ['NAXIS3']
sxaddpar, ll_header, 'NAXIS', 2
sxdelpar, ll_header, ['CRPIX1']
sxdelpar, ll_header, ['CRPIX2']
sxdelpar, ll_header, ['CRVAL1']
sxdelpar, ll_header, ['CRVAL2']
sxdelpar, ll_header, ['CDELT1']
sxdelpar, ll_header, ['CDELT2']
sxaddpar, ll_header, 'CRPIX1', ll_crpix1
sxaddpar, ll_header, 'CRPIX2', ll_crpix2
sxaddpar, ll_header, 'CRVAL1', ll_crval1
sxaddpar, ll_header, 'CRVAL2', ll_crval2
sxaddpar, ll_header, 'CDELT1', ll_cdelt1
sxaddpar, ll_header, 'CDELT2', ll_cdelt2

;Cubes
residual_cube = new_cube - fit_cube
cont_sub_cube = fit_cube - cont_fit
mwrfits, new_cube, 'll_smooth_cube.fits',ll_cube_header
mwrfits, new_unc, 'll_smooth_unc.fits',ll_cube_header
mwrfits, old_cube, 'll_cube.fits', ll_cube_header
mwrfits, old_unc, 'll_unc.fits', ll_cube_header
mwrfits, fit_cube, 'll_pahfit_cube.fits', ll_cube_header
mwrfits, cont_fit, 'll_pahfit_continuum_fit_cube.fits', ll_cube_header
mwrfits, residual_cube, 'll_residual_cube.fits', ll_cube_header
mwrfits, cont_sub_cube, 'll_pahfit_cont_sub_cube.fits', ll_cube_header

;Maps
mwrfits, SiII, 'SiII_map.fits', ll_header
mwrfits, SIII33, 'SIII33_map.fits', ll_header
mwrfits, H_28, 'H28_map.fits', ll_header
mwrfits, FeII, 'FeII_map.fits', ll_header
mwrfits, OIV, 'OIV_map.fits', ll_header
mwrfits, SIII18, 'SIII18_map.fits', ll_header
mwrfits, H_17, 'H17_map.fits', ll_header
mwrfits, NeIII, 'NeIII_map.fits', ll_header

;Line FWHM maps
mwrfits, SiII_fwhm, 'SiII_fwhm_map.fits', ll_header
mwrfits, SIII33_fwhm, 'SIII33_fwhm_map.fits', ll_header
mwrfits, H_28_fwhm, 'H28_fwhm_map.fits', ll_header
mwrfits, FeII_fwhm, 'FeII_fwhm_map.fits', ll_header
mwrfits, OIV_fwhm, 'OIV_fwhm_map.fits', ll_header
mwrfits, SIII18_fwhm, 'SIII18_fwhm_map.fits', ll_header
mwrfits, H_17_fwhm, 'H17_fwhm_map.fits', ll_header
mwrfits, NeIII_fwhm, 'NeIII_fwhm_map.fits', ll_header

;EW maps
mwrfits, ew_SiII, 'SiII_ew_map.fits', ll_header
mwrfits, ew_SIII33, 'SIII33_ew_map.fits', ll_header
mwrfits, ew_H_28, 'H28_ew_map.fits', ll_header
mwrfits, ew_FeII, 'FeII_ew_map.fits', ll_header
mwrfits, ew_OIV, 'OIV_ew_map.fits', ll_header
mwrfits, ew_SIII18, 'SIII18_ew_map.fits', ll_header
mwrfits, ew_H_17, 'H17_ew_map.fits', ll_header
mwrfits, ew_NeIII, 'NeIII_ew_map.fits', ll_header

;Uncertainty Maps
mwrfits, SiII_unc, 'SiII_map_unc.fits', ll_header
mwrfits, SIII33_unc, 'SIII33_map_unc.fits', ll_header
mwrfits, H_28_unc, 'H28_map_unc.fits', ll_header
mwrfits, FeII_unc, 'FeII_map_unc.fits', ll_header
mwrfits, OIV_unc, 'OIV_map_unc.fits', ll_header
mwrfits, SIII18_unc, 'SIII18_map_unc.fits', ll_header
mwrfits, H_17_unc, 'H17_map_unc.fits', ll_header
mwrfits, NeIII_unc, 'NeIII_map_unc.fits', ll_header

;Dust Features
mwrfits, df_33_1_micron,'df_33_1_micron_dust_feature.fits',ll_header
mwrfits, df_18_9_micron, 'df_18_9_micron_dust_feature.fits', ll_header
mwrfits, df_17_87_micron,'df_17_87_micron_dust_feature.fits',ll_header
mwrfits, df_17_38_micron, 'df_17_38_micron_dust_feature.fits',ll_header
mwrfits, df_17_micron, 'df_17_micron_dust_feature.fits',ll_header
mwrfits, df_16_5_micron, 'df_16_5_micron_dust_feature.fits',ll_header
mwrfits, df_15_9_micron, 'df_15_9_micron_dust_feature.fits',ll_header

;Dust feature FWHMs
mwrfits, df_33_1_micron_fwhm,'df_33_1_micron_fwhm.fits',ll_header
mwrfits, df_18_9_micron_fwhm, 'df_18_9_micron_fwhm.fits', ll_header
mwrfits, df_17_87_micron_fwhm,'df_17_87_micron_fwhm.fits',ll_header
mwrfits, df_17_38_micron_fwhm, 'df_17_38_micron_fwhm.fits',ll_header
mwrfits, df_17_micron_fwhm, 'df_17_micron_fwhm.fits',ll_header
mwrfits, df_16_5_micron_fwhm, 'df_16_5_micron_fwhm.fits',ll_header
mwrfits, df_15_9_micron_fwhm, 'df_15_9_micron_fwhm.fits',ll_header

;Dust Feature Uncertainties
mwrfits, df_33_1_micron_unc,'df_33_1_micron_dust_feature_unc.fits',ll_header
mwrfits, df_18_9_micron_unc, 'df_18_9_micron_dust_feature_unc.fits', ll_header
mwrfits, df_17_87_micron_unc,'df_17_87_micron_dust_feature_unc.fits',ll_header
mwrfits, df_17_38_micron_unc,'df_17_38_micron_dust_feature_unc.fits',ll_header
mwrfits, df_17_micron_unc,'df_17_micron_dust_feature_unc.fits',ll_header
mwrfits, df_16_5_micron_unc,'df_16_5_micron_dust_feature_unc.fits',ll_header
mwrfits, df_15_9_micron_unc,'df_15_9_micron_dust_feature_unc.fits',ll_header

;Chi Squared Map
mwrfits, chi_sq, 'chi_squared_map.fits', ll_header

;Beta Maps
mwrfits, beta_pahfit,'Beta_map.fits', ll_header
mwrfits, beta_unc_pahfit, 'Beta_unc_map.fits', ll_header

;Tau 9.7 Maps
mwrfits, tau_9_7_pahfit,'Tau_9_7_map.fits', ll_header
mwrfits, tau_9_7_unc_pahfit, 'Tau_9_7_unc_map.fits', ll_header

end

