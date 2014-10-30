pah74 = mrdfits('df_7_4_micron_dust_feature.fits', 0, pah74_header)
pah74_unc = mrdfits('df_7_4_micron_dust_feature_unc.fits', 0, pah74_unc_header)
pah6 = mrdfits('main_pah_feature_6_2_strength.fits', 0, pah6_header)
pah6_unc = mrdfits('main_pah_feature_6_2_unc.fits', 0, pah6_unc_header)
pah76 = mrdfits('df_7_6_micron_dust_feature.fits', 0, pah76_header)
pah76_unc = mrdfits('df_7_6_micron_dust_feature_unc.fits', 0, pah76_unc_header)
pah78 = mrdfits('df_7_8_micron_dust_feature.fits', 0, pah78_header)
pah78_unc = mrdfits('df_7_8_micron_dust_feature_unc.fits', 0, pah78_unc_header)

pah83 = mrdfits('df_8_3_micron_dust_feature.fits', 0, pah83_header)
pah83_unc = mrdfits('df_8_3_micron_dust_feature_unc.fits', 0, pah83_unc_header)

pah86 = mrdfits('df_8_6_micron_dust_feature.fits', 0, pah86_header)
pah86_unc = mrdfits('df_8_6_micron_dust_feature_unc.fits', 0, pah86_unc_header)

pah112 = mrdfits('df_11_2_micron_dust_feature.fits', 0, pah112_header)
pah112_unc = mrdfits('df_11_2_micron_dust_feature_unc.fits', 0, pah112_unc_header)

pah113 = mrdfits('df_11_3_micron_dust_feature.fits', 0, pah113_header)
pah113_unc = mrdfits('df_11_3_micron_dust_feature_unc.fits', 0, pah113_unc_header)

pah7 = mrdfits('main_pah_feature_7_7_strength.fits', 0, pah7_header)
pah7_unc = mrdfits('main_pah_feature_7_7_unc.fits', 0, pah7_unc_header)


plot, pah76/pah78, pah83/pah86, xrange=[0,2], yrange=[0,2],psym=4;, title='Drain and Li Plot for M51 Strip', xtitle='P(6.2 !7l!3m)/P(7.7 !7l!3m)', ytitle='P(11.3 !7l!3m)/P(7.7 !7l!3m)',xthick=3, ythick=3, charthick=3, /xlog, /ylog, xstyle=1, ystyle=1
plot, pah112/pah113, pah83/pah86, xrange=[0,5], yrange=[0,5],psym=4
plot, pah112/pah113, pah76/pah78, xrange=[0,5], yrange=[0,5],psym=4
;oploterror, pah76/pah78, pah83/pah86, sqrt(pah78_unc*pah78_unc+pah76_unc*pah76_unc),  sqrt(pah83_unc*pah83_unc+pah86_unc*pah86_unc), psym=4, /HIBAR, /LOBAR



end
