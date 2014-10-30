

pah11 = mrdfits('main_pah_feature_11_3_strength.fits', 0, pah11_header)
pah11_unc = mrdfits('main_pah_feature_11_3_unc.fits', 0, pah11_unc_header)
pah6 = mrdfits('main_pah_feature_6_2_strength.fits', 0, pah6_header)
pah6_unc = mrdfits('main_pah_feature_6_2_unc.fits', 0, pah6_unc_header)
pah7 = mrdfits('main_pah_feature_7_7_strength.fits', 0, pah7_header)
pah7_unc = mrdfits('main_pah_feature_7_7_unc.fits', 0, pah7_unc_header)
unc1 = (pah6/pah7)*sqrt((pah6_unc/pah6)*(pah6_unc/pah6)+(pah7_unc/pah7)*(pah7_unc/pah7))
unc2 = (pah11/pah7)*sqrt((pah11_unc/pah11)*(pah11_unc/pah11)+(pah7_unc/pah7)*(pah7_unc/pah7))

set_plot, 'ps'
device, filename = 'figure_dlp_ngc2841.ps', /encapsulated
plot, pah6/pah7, pah11/pah7, xrange=[.1,.5], yrange=[.04,2],psym=4, xtitle='PAH(6.2 !7l!3m)/PAH(7.7 !7l!3m)', ytitle='PAH(11.3 !7l!3m)/PAH(7.7 !7l!3m)',xthick=3, ythick=3, charthick=3, /xlog, /ylog, xstyle=1, ystyle=1
xyouts, .11, 1.25, 'NGC 2841', charsize = 1.5, charthick = 3
;oploterror, pah6/pah7, pah11/pah7, unc1, unc2, psym=4;, /HIBAR, /LOBAR
device, /close
end
