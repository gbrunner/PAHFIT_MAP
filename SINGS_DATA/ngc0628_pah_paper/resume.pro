mwrfits, new_cube, 'sl_cube_smooth.fits',sl_cube_header
mwrfits, new_unc, 'sl_unc_smooth.fits',sl_cube_header
mwrfits, old_cube, 'sl_cube.fits', sl_cube_header
mwrfits, old_unc, 'sl_unc.fits', sl_cube_header 
mwrfits, fit_cube, 'sl_pahfit_cube.fits', sl_cube_header
mwrfits, cont_fit, 'sl_pahfit_continuum_fit_cube.fits', sl_cube_header
mwrfits, residual_cube, 'sl_residual_cube.fits', sl_cube_header
mwrfits, cont_sub_cube, 'sl_pahfit_cont_sub_cube.fits', sl_cube_header

;write main feature maps
mwrfits, main_pah_feature_6_2_strength, 'main_pah_feature_6_2_strength.fits', sl_header
mwrfits, main_pah_feature_7_7_strength, 'main_pah_feature_7_7_strength.fits', sl_header
mwrfits, main_pah_feature_8_3_strength, 'main_pah_feature_8_3_strength.fits', sl_header
mwrfits, main_pah_feature_8_6_strength, 'main_pah_feature_8_6_strength.fits', sl_header
mwrfits, main_pah_feature_11_3_strength, 'main_pah_feature_11_3_strength.fits', sl_header
mwrfits, main_pah_feature_12_0_strength, 'main_pah_feature_12_0_strength.fits', sl_header
mwrfits, main_pah_feature_12_6_strength, 'main_pah_feature_12_6_strength.fits', sl_header
mwrfits, main_pah_feature_13_6_strength, 'main_pah_feature_13_6_strength.fits', sl_header
mwrfits, main_pah_feature_14_2_strength, 'main_pah_feature_14_2_strength.fits', sl_header

;write main feature unc maps
mwrfits, main_pah_feature_6_2_strength_unc, 'main_pah_feature_6_2_unc.fits', sl_header
mwrfits, main_pah_feature_7_7_strength_unc, 'main_pah_feature_7_7_unc.fits', sl_header
mwrfits, main_pah_feature_8_3_strength_unc, 'main_pah_feature_8_3_unc.fits', sl_header
mwrfits, main_pah_feature_8_6_strength_unc, 'main_pah_feature_8_6_unc.fits', sl_header
mwrfits, main_pah_feature_11_3_strength_unc, 'main_pah_feature_11_3_unc.fits', sl_header
mwrfits, main_pah_feature_12_0_strength_unc, 'main_pah_feature_12_0_unc.fits', sl_header
mwrfits, main_pah_feature_12_6_strength_unc, 'main_pah_feature_12_6_unc.fits', sl_header
mwrfits, main_pah_feature_13_6_strength_unc, 'main_pah_feature_13_6_unc.fits', sl_header
mwrfits, main_pah_feature_14_2_strength_unc, 'main_pah_feature_14_2_unc.fits', sl_header

;write main feature alt 1 unc maps
mwrfits, main_pah_feature_6_2_strength_unc_alt1, 'main_pah_feature_6_2_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_7_7_strength_unc_alt1, 'main_pah_feature_7_7_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_8_3_strength_unc_alt1, 'main_pah_feature_8_3_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_8_6_strength_unc_alt1, 'main_pah_feature_8_6_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_11_3_strength_unc_alt1, 'main_pah_feature_11_3_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_12_0_strength_unc_alt1, 'main_pah_feature_12_0_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_12_6_strength_unc_alt1, 'main_pah_feature_12_6_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_13_6_strength_unc_alt1, 'main_pah_feature_13_6_unc_alt1.fits', sl_header
mwrfits, main_pah_feature_14_2_strength_unc_alt1, 'main_pah_feature_14_2_unc_alt1.fits', sl_header

;write main feature alt 2 unc maps
mwrfits, main_pah_feature_6_2_strength_unc_alt2, 'main_pah_feature_6_2_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_7_7_strength_unc_alt2, 'main_pah_feature_7_7_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_8_3_strength_unc_alt2, 'main_pah_feature_8_3_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_8_6_strength_unc_alt2, 'main_pah_feature_8_6_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_11_3_strength_unc_alt2, 'main_pah_feature_11_3_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_12_0_strength_unc_alt2, 'main_pah_feature_12_0_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_12_6_strength_unc_alt2, 'main_pah_feature_12_6_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_13_6_strength_unc_alt2, 'main_pah_feature_13_6_unc_alt2.fits', sl_header
mwrfits, main_pah_feature_14_2_strength_unc_alt2, 'main_pah_feature_14_2_unc_alt2.fits', sl_header

;write main feature eqw maps
mwrfits, main_pah_feature_6_2_eqw, 'main_pah_feature_6_2_eqw.fits', sl_header
mwrfits, main_pah_feature_7_7_eqw, 'main_pah_feature_7_7_eqw.fits', sl_header
mwrfits, main_pah_feature_8_3_eqw, 'main_pah_feature_8_3_eqw.fits', sl_header
mwrfits, main_pah_feature_8_6_eqw, 'main_pah_feature_8_6_eqw.fits', sl_header
mwrfits, main_pah_feature_11_3_eqw, 'main_pah_feature_11_3_eqw.fits', sl_header
mwrfits, main_pah_feature_12_0_eqw, 'main_pah_feature_12_0_eqw.fits', sl_header
mwrfits, main_pah_feature_12_6_eqw, 'main_pah_feature_12_6_eqw.fits', sl_header
mwrfits, main_pah_feature_13_6_eqw, 'main_pah_feature_13_6_eqw.fits', sl_header
mwrfits, main_pah_feature_14_2_eqw, 'main_pah_feature_14_2_eqw.fits', sl_header


;Write Maps
mwrfits, H2_s7, 'H5_map.fits', sl_header
mwrfits, H2_s6, 'H5_5_map.fits', sl_header
mwrfits, H2_s5, 'H7_map.fits', sl_header
mwrfits, ArII, 'ArII_map.fits', sl_header
mwrfits, H2_s4, 'H8_map.fits', sl_header
mwrfits, ArIII, 'ArIII_map.fits', sl_header
mwrfits, H2_s3, 'H9_map.fits', sl_header
mwrfits, SIV, 'SIV_map.fits', sl_header
mwrfits, H2_s2, 'H12_map.fits', sl_header
mwrfits, NeII, 'NeII_map.fits', sl_header

;Line FWHM Maps
mwrfits, H2_s7_fwhm, 'H5_fwhm_map.fits', sl_header
mwrfits, H2_s6_fwhm, 'H5_5_fwhm_map.fits', sl_header
mwrfits, H2_s5_fwhm, 'H7_fwhm_map.fits', sl_header
mwrfits, ArII_fwhm, 'ArII_fwhm_map.fits', sl_header
mwrfits, H2_s4_fwhm, 'H8_fwhm_map.fits', sl_header
mwrfits, ArIII_fwhm, 'ArIII_fwhm_map.fits', sl_header
mwrfits, H2_s3_fwhm, 'H9_fwhm_map.fits', sl_header
mwrfits, SIV_fwhm, 'SIV_fwhm_map.fits', sl_header
mwrfits, H2_s2_fwhm, 'H12_fwhm_map.fits', sl_header
mwrfits, NeII_fwhm, 'NeII_fwhm_map.fits', sl_header

;Equivalent width maps
mwrfits, ew_H2_s7, 'H5_ew_map.fits',sl_header
mwrfits, ew_H2_s6, 'H5_5_ew_map.fits',sl_header
mwrfits, ew_H2_s5, 'H7_ew_map.fits',sl_header
mwrfits, ew_ArII, 'ArII_ew_map.fits',sl_header
mwrfits, ew_H2_s4, 'H8_ew_map.fits',sl_header
mwrfits, ew_ArIII, 'ArIII_ew_map.fits',sl_header
mwrfits, ew_H2_s3, 'H9_ew_map.fits',sl_header
mwrfits, ew_SIV, 'SIV_ew_map.fits',sl_header
mwrfits, ew_H2_s2, 'H12_ew_map.fits',sl_header
mwrfits, ew_NeII, 'NeII_ew_map.fits',sl_header

;Line strength uncertainty maps
mwrfits, H2_s7_unc, 'H5_map_unc.fits', sl_header
mwrfits, H2_s6_unc, 'H5_5_map_unc.fits', sl_header
mwrfits, H2_s5_unc, 'H7_map_unc.fits', sl_header
mwrfits, ArII_unc, 'ArII_map_unc.fits', sl_header
mwrfits, H2_s4_unc, 'H8_map_unc.fits', sl_header
mwrfits, ArIII_unc, 'ArIII_map_unc.fits', sl_header
mwrfits, H2_s3_unc, 'H9_map_unc.fits', sl_header
mwrfits, SIV_unc, 'SIV_map_unc.fits', sl_header
mwrfits, H2_s2_unc, 'H12_map_unc.fits', sl_header
mwrfits, NeII_unc, 'NeII_map_unc.fits', sl_header

;Dust Feature Maps
mwrfits, df_14_1_micron, 'df_14_1_micron_dust_feature.fits', sl_header
mwrfits, df_14_0_micron, 'df_14_0_micron_dust_feature.fits', sl_header
mwrfits, df_13_5_micron, 'df_13_5_micron_dust_feature.fits', sl_header
mwrfits, df_12_7_micron, 'df_12_7_micron_dust_feature.fits', sl_header
mwrfits, df_12_6_micron, 'df_12_6_micron_dust_feature.fits', sl_header
mwrfits, df_12_micron, 'df_12_micron_dust_feature.fits', sl_header
mwrfits, df_11_3_micron, 'df_11_3_micron_dust_feature.fits', sl_header
mwrfits, df_11_2_micron, 'df_11_2_micron_dust_feature.fits', sl_header
mwrfits, df_10_7_micron, 'df_10_7_micron_dust_feature.fits', sl_header
mwrfits, df_8_6_micron, 'df_8_6_micron_dust_feature.fits', sl_header
mwrfits, df_8_3_micron, 'df_8_3_micron_dust_feature.fits', sl_header
mwrfits, df_7_8_micron, 'df_7_8_micron_dust_feature.fits', sl_header
mwrfits, df_7_6_micron, 'df_7_6_micron_dust_feature.fits', sl_header
mwrfits, df_7_4_micron, 'df_7_4_micron_dust_feature.fits', sl_header
mwrfits, df_6_7_micron, 'df_6_7_micron_dust_feature.fits', sl_header
mwrfits, df_6_2_micron, 'df_6_2_micron_dust_feature.fits', sl_header
mwrfits, df_5_7_micron, 'df_5_7_micron_dust_feature.fits', sl_header
mwrfits, df_5_2_micron, 'df_5_2_micron_dust_feature.fits', sl_header

;Dust Feature Uncertainty Maps
mwrfits, df_14_1_micron_unc, 'df_14_1_micron_dust_feature_unc.fits', sl_header
mwrfits, df_14_0_micron_unc, 'df_14_0_micron_dust_feature_unc.fits', sl_header
mwrfits, df_13_5_micron_unc, 'df_13_5_micron_dust_feature_unc.fits', sl_header
mwrfits, df_12_7_micron_unc, 'df_12_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_12_6_micron_unc, 'df_12_6_micron_dust_feature_unc.fits', sl_header
mwrfits, df_12_micron_unc, 'df_12_micron_dust_feature_unc.fits', sl_header
mwrfits, df_11_3_micron_unc, 'df_11_3_micron_dust_feature_unc.fits', sl_header
mwrfits, df_11_2_micron_unc, 'df_11_2_micron_dust_feature_unc.fits', sl_header
mwrfits, df_10_7_micron_unc, 'df_10_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_8_6_micron_unc, 'df_8_6_micron_dust_feature_unc.fits', sl_header
mwrfits, df_8_3_micron_unc, 'df_8_3_micron_dust_feature_unc.fits', sl_header
mwrfits, df_7_8_micron_unc, 'df_7_8_micron_dust_feature_unc.fits', sl_header
mwrfits, df_7_6_micron_unc, 'df_7_6_micron_dust_feature_unc.fits', sl_header
mwrfits, df_7_4_micron_unc, 'df_7_4_micron_dust_feature_unc.fits', sl_header
mwrfits, df_6_7_micron_unc, 'df_6_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_6_2_micron_unc, 'df_6_2_micron_dust_feature_unc.fits', sl_header
mwrfits, df_5_7_micron_unc, 'df_5_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_5_2_micron_unc, 'df_5_2_micron_dust_feature_unc.fits', sl_header

;Dust Feature FWHM
mwrfits, df_14_1_micron_fwhm, 'df_14_1_micron_fwhm.fits', sl_header
mwrfits, df_14_0_micron_fwhm, 'df_14_0_micron_fwhm.fits', sl_header
mwrfits, df_13_5_micron_fwhm, 'df_13_5_micron_fwhm.fits', sl_header
mwrfits, df_12_7_micron_fwhm, 'df_12_7_micron_fwhm.fits', sl_header
mwrfits, df_12_6_micron_fwhm, 'df_12_6_micron_fwhm.fits', sl_header
mwrfits, df_12_micron_fwhm, 'df_12_micron_fwhm.fits', sl_header
mwrfits, df_11_3_micron_fwhm, 'df_11_3_micron_fwhm.fits', sl_header
mwrfits, df_11_2_micron_fwhm, 'df_11_2_micron_fwhm.fits', sl_header
mwrfits, df_10_7_micron_fwhm, 'df_10_7_micron_fwhm.fits', sl_header
mwrfits, df_8_6_micron_fwhm, 'df_8_6_micron_fwhm.fits', sl_header
mwrfits, df_8_3_micron_fwhm, 'df_8_3_micron_fwhm.fits', sl_header
mwrfits, df_7_8_micron_fwhm, 'df_7_8_micron_fwhm.fits', sl_header
mwrfits, df_7_6_micron_fwhm, 'df_7_6_micron_fwhm.fits', sl_header
mwrfits, df_7_4_micron_fwhm, 'df_7_4_micron_fwhm.fits', sl_header
mwrfits, df_6_7_micron_fwhm, 'df_6_7_micron_fwhm.fits', sl_header
mwrfits, df_6_2_micron_fwhm, 'df_6_2_micron_fwhm.fits', sl_header
mwrfits, df_5_7_micron_fwhm, 'df_5_7_micron_fwhm.fits', sl_header
mwrfits, df_5_2_micron_fwhm, 'df_5_2_micron_fwhm.fits', sl_header

;Chi Squared Maps
mwrfits, chi_sq, 'chi_squared_map.fits', sl_header

;Beta Maps
mwrfits, beta_pahfit,'Beta_map.fits', sl_header
mwrfits, beta_unc_pahfit, 'Beta_unc_map.fits', sl_header

;Tau 9.7 Maps
mwrfits, tau_9_7_pahfit,'Tau_9_7_map.fits', sl_header
mwrfits, tau_9_7_unc_pahfit, 'Tau_9_7_unc_map.fits', sl_header

end

