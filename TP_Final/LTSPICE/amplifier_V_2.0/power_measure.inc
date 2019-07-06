.meas TRAN IEQ1_max MAX -Ix(Q1:3)
.meas TRAN IEQ1_rms RMS -Ix(Q1:3) FROM {datastart}
.meas TRAN VCEQ1_max MAX V(+HV, EQ1)
.meas TRAN PQ1_max MAX V(+HV,EQ1)*(-Ix(Q1:3))+V(EQ7,EQ1)*Ix(Q1:1) FROM {datastart}
.meas TRAN PQ1_avg AVG V(+HV,EQ1)*(-Ix(Q1:3))+V(EQ7,EQ1)*Ix(Q1:1) FROM {datastart}

.meas TRAN IEQ2_max MAX Ix(Q2:3)
.meas TRAN IEQ2_rms RMS Ix(Q2:3) FROM {datastart}
.meas TRAN VECQ2_max MAX -V(-HV, EQ2)
.meas TRAN PQ2_max MAX -V(-HV,EQ2)*(Ix(Q2:3))-V(EQ8,EQ2)*(-Ix(Q2:1)) FROM {datastart}
.meas TRAN PQ2_avg AVG -V(-HV,EQ2)*(Ix(Q2:3))-V(EQ8,EQ2)*(-Ix(Q2:1)) FROM {datastart}

.meas TRAN IEQ3_max MAX -Ix(Q3:3)
.meas TRAN IEQ3_rms RMS -Ix(Q3:3) FROM {datastart}
.meas TRAN VCEQ3_max MAX V(MID_POS,EQ3)
.meas TRAN PQ3_max MAX V(MID_POS,EQ3)*(-Ix(Q3:3))+V(EQ9,EQ3)*Ix(Q3:1) FROM {datastart}
.meas TRAN PQ3_avg AVG V(MID_POS,EQ3)*(-Ix(Q3:3))+V(EQ9,EQ3)*Ix(Q3:1) FROM {datastart}

.meas TRAN IEQ4_max MAX Ix(Q4:3)
.meas TRAN IEQ4_rms RMS Ix(Q4:3) FROM {datastart}
.meas TRAN VECQ4_max MAX V(EQ4,MID_NEG)
.meas TRAN PQ4_max MAX -V(MID_NEG,EQ4)*(Ix(Q4:3))-V(EQ10,EQ4)*(-Ix(Q4:1)) FROM {datastart}
.meas TRAN PQ4_avg AVG -V(MID_NEG,EQ4)*(Ix(Q4:3))-V(EQ10,EQ4)*(-Ix(Q4:1)) FROM {datastart}

.meas TRAN IEQ5_max MAX -Ix(Q5:3)
.meas TRAN IEQ5_rms RMS -Ix(Q5:3) FROM {datastart}
.meas TRAN VCEQ5_max MAX V(+HV,EQ5)
.meas TRAN PQ5_max MAX V(+HV,EQ5)*(-Ix(Q5:3))+V(EQ7,EQ5)*Ix(Q5:1) FROM {datastart}
.meas TRAN PQ5_avg AVG V(+HV,EQ5)*(-Ix(Q5:3))+V(EQ7,EQ5)*Ix(Q5:1) FROM {datastart}

.meas TRAN IEQ6_max MAX Ix(Q6:3)
.meas TRAN IEQ6_rms RMS Ix(Q6:3) FROM {datastart}
.meas TRAN VECQ6_max MAX V(EQ6,-HV)
.meas TRAN PQ6_max MAX -V(-HV,EQ6)*(Ix(Q6:3))-V(EQ8,EQ6)*(-Ix(Q6:1)) FROM {datastart}
.meas TRAN PQ6_avg AVG -V(-HV,EQ6)*(Ix(Q6:3))-V(EQ8,EQ6)*(-Ix(Q6:1)) FROM {datastart}

.meas TRAN IEQ7_max MAX 1000*(-Ie(Q7))
.meas TRAN IEQ7_rms RMS 1000*(-Ie(Q7)) FROM {datastart}
.meas TRAN VCEQ7_max MAX V(+HV,EQ7)
.meas TRAN PQ7_max MAX V(+HV,EQ7)*Ic(Q7)+V(BQ7,EQ7)*Ib(Q7)
.meas TRAN PQ7_avg AVG 1000*V(+HV,EQ7)*Ic(Q7)+V(BQ7,EQ7)*Ib(Q7) FROM {datastart}

.meas TRAN IEQ8_max MAX 1000*Ie(Q8)
.meas TRAN IEQ8_rms RMS 1000*Ie(Q8) FROM {datastart}
.meas TRAN VECQ8_max MAX V(EQ8,-HV)
.meas TRAN PQ8_max MAX V(-HV,EQ8)*Ic(Q8)+V(BQ8,EQ8)*Ib(Q8)
.meas TRAN PQ8_avg AVG 1000*V(-HV,EQ8)*Ic(Q8)+V(BQ8,EQ8)*Ib(Q8) FROM {datastart}

.meas TRAN IEQ9_max MAX 1000*(-Ie(Q9))
.meas TRAN IEQ9_rms RMS 1000*(-Ie(Q9)) FROM {datastart}
.meas TRAN VCEQ9_max MAX V(+HV,EQ9)
.meas TRAN PQ9_max MAX V(+HV,EQ9)*Ic(Q9)+V(BQ9,EQ9)*Ib(Q9) FROM {datastart}
.meas TRAN PQ9_avg AVG 1000*V(+HV,EQ9)*Ic(Q9)+V(BQ9,EQ9)*Ib(Q9)

.meas TRAN IEQ10_max MAX 1000*Ie(Q10)
.meas TRAN IEQ10_rms RMS 1000*Ie(Q10) FROM {datastart}
.meas TRAN VECQ10_max MAX V(EQ10,-HV)
.meas TRAN PQ10_max MAX V(-HV,EQ10)*Ic(Q10)+V(BQ10,EQ10)*Ib(Q10) FROM {datastart}
.meas TRAN PQ10_avg AVG 1000*V(-HV,EQ10)*Ic(Q10)+V(BQ10,EQ10)*Ib(Q10)

;.meas TRAN IEQ11_max MAX 1000*(-Ie(Q11))
;.meas TRAN IEQ11_rms RMS 1000*(-Ie(Q11)) FROM {datastart}
;.meas TRAN VCEQ11_max MAX V(CQ11,out)
;.meas TRAN PQ11_max MAX 1000*V(CQ11,out)*Ic(Q11)+V(BQ11,out)*Ib(Q11) FROM {datastart}
;.meas TRAN PQ11_avg AVG 1000*V(CQ11,out)*Ic(Q11)+V(BQ11,out)*Ib(Q11) FROM {datastart}

;.meas TRAN IEQ12_max MAX 1000*Ie(Q12)
;.meas TRAN IEQ12_rms RMS 1000*Ie(Q12) FROM {datastart}
;.meas TRAN VECQ12_max MAX -V(CQ12,out)
;.meas TRAN PQ12_max MAX 1000*V(CQ12,out)*Ic(Q12)+V(BQ12,out)*Ib(Q12) FROM {datastart}
;.meas TRAN PQ12_avg AVG 1000*V(CQ12,out)*Ic(Q12)+V(BQ12,out)*Ib(Q12) FROM {datastart}

.meas TRAN IEQ15_max MAX 1000*Ie(Q15)
.meas TRAN IEQ15_rms RMS 1000*Ie(Q15)
.meas TRAN VECQ15_max MAX V(EQ15,CQ15)
.meas TRAN PQ15_max MAX V(CQ15,EQ15)*Ic(Q15)+V(BQ15,EQ15)*Ib(Q15)
.meas TRAN PQ15_avg AVG 1000*V(CQ15,EQ15)*Ic(Q15)+V(BQ15,EQ15)*Ib(Q15)

.meas TRAN IEQ16_max MAX 1000*(-Ie(Q16))
.meas TRAN IEQ16_rms RMS 1000*(-Ie(Q16))
.meas TRAN VCEQ16_max MAX -V(EQ16,CQ16)
.meas TRAN PQ16_max MAX V(CQ16,EQ16)*Ic(Q16)+V(BQ16,EQ16)*Ib(Q16)
.meas TRAN PQ16_avg AVG 1000*V(CQ16,EQ16)*Ic(Q16)+V(BQ16,EQ16)*Ib(Q16)

.meas TRAN IEQ17_max MAX 1000*Ie(Q17)
.meas TRAN IEQ17_rms RMS 1000*Ie(Q17)
.meas TRAN VECQ17_max MAX V(EQ17)
.meas TRAN PQ17_max MAX 1000*(-V(EQ17)*Ic(Q17)+V(POS_DIFF_OUT,EQ17)*Ib(Q17))
.meas TRAN PQ17_avg AVG 1000*(-V(EQ17)*Ic(Q17)+V(POS_DIFF_OUT,EQ17)*Ib(Q17))

.meas TRAN IEQ18_max MAX 1000*(-Ie(Q18))
.meas TRAN IEQ18_rms RMS 1000*(-Ie(Q18))
.meas TRAN VCEQ18_max MAX -V(EQ18)
.meas TRAN PQ18_max MAX 1000*(-V(EQ18)*Ic(Q18)+V(NEG_DIFF_OUT,EQ18)*Ib(Q18))
.meas TRAN PQ18_avg AVG 1000*(-V(EQ18)*Ic(Q18)+V(NEG_DIFF_OUT,EQ18)*Ib(Q18))

.meas TRAN IEQ19_max MAX 1000*(-Ie(Q19))
.meas TRAN IEQ19_rms RMS 1000*(-Ie(Q19))
.meas TRAN VCEQ19_max MAX V(VBEM1,VBEMID)
.meas TRAN PQ19_max MAX 1000*V(VBEM1,VBEMID)*Ic(Q19)+V(BQ19,VBEMID)*Ib(Q19)
.meas TRAN PQ19_avg AVG 1000*V(VBEM1,VBEMID)*Ic(Q19)+V(BQ19,VBEMID)*Ib(Q19)

.meas TRAN IEQ20_max MAX 1000*Ie(Q20)
.meas TRAN IEQ20_rms RMS 1000*Ie(Q20)
.meas TRAN VECQ20_max MAX +V(VBEM2,VBEMID)
.meas TRAN PQ20_max MAX 1000*V(VBEM2,VBEMID)*Ic(Q20)+V(BQ20,VBEMID)*Ib(Q20)
.meas TRAN PQ20_avg AVG 1000*V(VBEM2,VBEMID)*Ic(Q20)+V(BQ20,VBEMID)*Ib(Q20)



.meas TRAN IEQ31_max MAX 1000*(-Ie(Q31))
.meas TRAN IEQ31_rms RMS 1000*(-Ie(Q31))
.meas TRAN VCEQ31_max MAX V(CQ31,CQ33)
.meas TRAN PQ31_max MAX 1000*V(CQ31,CQ33)*Ic(Q31)+V(+RLV,CQ33)*Ib(Q31)
.meas TRAN PQ31_avg AVG 1000*V(CQ31,CQ33)*Ic(Q31)+V(+RLV,CQ33)*Ib(Q31)

.meas TRAN IEQ32_max MAX 1000*Ie(Q32)
.meas TRAN IEQ32_rms RMS 1000*Ie(Q32)
.meas TRAN VECQ32_max MAX -V(CQ32,CQ32)
.meas TRAN PQ32_max MAX 1000*V(CQ32,CQ34)*Ic(Q32)+V(-RLV,CQ34)*Ib(Q32)
.meas TRAN PQ32_avg AVG 1000*V(CQ32,CQ34)*Ic(Q32)+V(-RLV,CQ34)*Ib(Q32)

.meas TRAN IEQ33_max MAX 1000*(-Ie(Q33))
.meas TRAN IEQ33_rms RMS 1000*(-Ie(Q33))
.meas TRAN VCEQ33_max MAX V(CQ33,CQ35)
.meas TRAN PQ33_max MAX 1000*V(CQ33,CQ35)*Ic(Q33)+V(fin,CQ35)*Ib(Q33)
.meas TRAN PQ33_avg AVG 1000*V(CQ33,CQ35)*Ic(Q33)+V(fin,CQ35)*Ib(Q33)

.meas TRAN IEQ34_max MAX 1000*Ie(Q34)
.meas TRAN IEQ34_rms RMS 1000*Ie(Q34)
.meas TRAN VECQ34_max MAX -V(CQ34,CQ34)
.meas TRAN PQ34_max MAX 1000*V(CQ34,CQ36)*Ic(Q34)+V(fin,CQ36)*Ib(Q34)
.meas TRAN PQ34_avg AVG 1000*V(CQ34,CQ36)*Ic(Q34)+V(fin,CQ36)*Ib(Q34)

.meas TRAN IEQ35_max MAX 1000*(-Ie(Q35))
.meas TRAN IEQ35_rms RMS 1000*(-Ie(Q35))
.meas TRAN VCEQ35_max MAX V(CQ35,EQ35)
.meas TRAN PQ35_max MAX 1000*V(CQ35,EQ35)*Ic(Q35)+V(BQ35,EQ35)*Ib(Q35)
.meas TRAN PQ35_avg AVG 1000*V(CQ35,EQ35)*Ic(Q35)+V(BQ35,EQ35)*Ib(Q35)

.meas TRAN IEQ36_max MAX 1000*Ie(Q36)
.meas TRAN IEQ36_rms RMS 1000*Ie(Q36)
.meas TRAN VECQ36_max MAX -V(CQ36,EQ36)
.meas TRAN PQ36_max MAX 1000*V(CQ36,EQ36)*Ic(Q36)+V(BQ36,EQ36)*Ib(Q36)
.meas TRAN PQ36_avg AVG 1000*V(CQ36,EQ36)*Ic(Q36)+V(BQ36,EQ36)*Ib(Q36)


.meas TRAN VD1_max MAX -V(+LV,MID_POS)
.meas TRAN ID1_max MAX I(D1)
.meas TRAN PD1_max MAX 1000*V(+LV,MID_POS)*I(D1)
.meas TRAN PD1_avg AVG 1000*V(+LV,MID_POS)*I(D1)

.meas TRAN VD2_max MAX V(-LV,MID_NEG)
.meas TRAN ID2_max MAX I(D2)
.meas TRAN PD2_max MAX 1000*(-V(-LV,MID_NEG)*I(D2))
.meas TRAN PD2_avg AVG  1000*(-V(-LV,MID_NEG)*I(D2))

.meas TRAN VD3_max MAX -V(CQ15,BQ7)
.meas TRAN ID3_max MAX 1000*I(D3)
.meas TRAN PD3_max MAX 1000*V(CQ15,BQ7)*I(D3)
.meas TRAN PD3_avg AVG 1000*V(CQ15,BQ7)*I(D3)

.meas TRAN VD4_max MAX V(CQ16,BQ8)
.meas TRAN ID4_max MAX 1000*I(D4)
.meas TRAN PD4_max MAX 1000*(-V(CQ16,BQ8)*I(D4))
.meas TRAN PD4_avg AVG 1000*(-V(CQ16,BQ8)*I(D4))

.meas TRAN VDZ1_max MAX V(CQ15,VBEM1)
.meas TRAN IDZ1_max MAX 1000*(-I(DZ1))
.meas TRAN PDZ1_max MAX 1000*V(VBEM1,CQ15)*I(DZ1)
.meas TRAN PDZ1_avg AVG 1000*V(VBEM1,CQ15)*I(DZ1)

.meas TRAN VDZ2_max MAX -V(CQ16,VBEM2)
.meas TRAN IDZ2_max MAX 1000*(-I(DZ2))
.meas TRAN PDZ2_max MAX 1000*(-V(VBEM2,CQ16)*I(DZ2))
.meas TRAN PDZ2_avg AVG 1000*(-V(VBEM2,CQ16)*I(DZ2))

.meas TRAN VDZ3_max MAX V(BQ15,EQ17)
.meas TRAN IDZ3_max MAX 1000*Ix(DZ3:-)
.meas TRAN PDZ3_max MAX 1000*V(BQ15,EQ17)*Ix(DZ3:-)
.meas TRAN PDZ3_avg AVG 1000*V(BQ15,EQ17)*Ix(DZ3:-)

.meas TRAN VDZ4_max MAX -V(BQ16,EQ18)
.meas TRAN IDZ4_max MAX 1000*Ix(DZ4:-)
.meas TRAN PDZ4_max MAX 1000*(-V(BQ16,EQ18)*Ix(DZ4:-))
.meas TRAN PDZ4_avg AVG 1000*(-V(BQ16,EQ18)*Ix(DZ4:-))



.meas TRAN VD35_max MAX -V(BQ35,CD35)
.meas TRAN ID35_max MAX 1000*I(D35)
.meas TRAN PD35_max MAX 1000*V(BQ35,CD35)*I(D35)
.meas TRAN PD35_avg AVG 1000*V(BQ35,CD35)*I(D35)

.meas TRAN VD36_max MAX -V(BQ36,CD36)
.meas TRAN ID36_max MAX 1000*I(D36)
.meas TRAN PD36_max MAX 1000*(-V(BQ36,CD36)*I(D36))
.meas TRAN PD36_avg AVG 1000*(-V(BQ36,CD36)*I(D36))

.meas TRAN VD37_max MAX -V(CD35,-RLV)
.meas TRAN ID37_max MAX 1000*I(D37)
.meas TRAN PD37_max MAX 1000*V(CD35,-RLV)*I(D37)
.meas TRAN PD37_avg AVG 1000*V(CD35,-RLV)*I(D37)

.meas TRAN VD38_max MAX -V(CD36,+RLV)
.meas TRAN ID38_max MAX 1000*I(D38)
.meas TRAN PD38_max MAX 1000*(-V(CD36,+RLV)*I(D38))
.meas TRAN PD38_avg AVG 1000*(-V(CD36,+RLV)*I(D38))



.meas TRAN VCF1_max MAX V(+HV)

.meas TRAN VCF2_max MAX -V(-HV)

.meas TRAN VCF3_max MAX V(+LV)

.meas TRAN VCF4_max MAX -V(-LV)

.meas TRAN VCF5_max MAX V(+HV)

.meas TRAN VCF6_max MAX -V(-HV)

.meas TRAN VCF7_max MAX V(+LV)

.meas TRAN VCF8_max MAX -V(-LV)

.meas TRAN VCF9_max MAX V(+HVF)

.meas TRAN VCF10_max MAX -V(-HVF)

.meas TRAN VCF11_max MAX V(+HVF)

.meas TRAN VCF12_max MAX -V(-HVF)

.meas TRAN VCC1_max MAX V(EQ9,EQ10)

.meas TRAN VCC2_max MAX V(VBEM1,VBEM2)

.meas TRAN VCC3_max MAX V(+HV,BQ7)

.meas TRAN VCC4_max MAX -V(-HV,BQ8)

.meas TRAN VCC5_max MAX V(POS_DIFF_OUT,CQ15)

.meas TRAN VCC6_max MAX -V(NEG_DIFF_OUT,CQ16)

.meas TRAN VCC7_max MAX V(out,fin)

.meas TRAN VCAF_max MAX -V(CAFN)



.meas TRAN VCF31_max MAX V(+RLV)

.meas TRAN VCF32_max MAX -V(-RLV)

.meas TRAN VCF33_max MAX V(+RLV)

.meas TRAN VCF34_max MAX -V(-RLV)



;.meas TRAN PR1_avg AVG 1000*V(EQ1,MID_POS)*I(R1)

;.meas TRAN PR2_avg AVG 1000*(-V(EQ2,MID_NEG)*I(R2))

;.meas TRAN PR3_avg AVG 1000*V(EQ3,out)*I(R3)

;.meas TRAN PR4_avg AVG 1000*(-V(EQ4,out)*I(R4))

;.meas TRAN PR5_avg AVG 1000*V(EQ5,MID_POS)*I(R5)

;.meas TRAN PR6_avg AVG 1000*(-V(EQ6,MID_NEG)*I(R6))

.meas TRAN PRF1_avg AVG 1000*V(+HV,+HVF)*I(RF1)

.meas TRAN PRF2_avg AVG 1000*V(-HV,-HVF)*I(RF2)

.meas TRAN PR9_avg AVG 1000*V(EQ7,MID_POS)*I(R9)

.meas TRAN PR10_avg AVG 1000*(-V(EQ8,MID_NEG)*I(R10))

.meas TRAN PR11_avg AVG 1000*V(EQ9,MID_RE)*I(R11)

.meas TRAN PR12_avg AVG 1000*(-V(EQ10,MID_RE)*I(R12))

.meas TRAN PR15_avg AVG 1000*V(+HVF,EQ15)*I(R15)

.meas TRAN PR16_avg AVG 1000*(-V(-HVF,EQ16)*I(R16))

.meas TRAN PR17_avg AVG 1000*V(VBEM1,BQ9)*I(R17)

.meas TRAN PR18_avg AVG 1000*(-V(VBEM2,BQ10)*I(R18))

.meas TRAN PR19_avg AVG 1000*V(+HV,BQ15)*I(R19)

.meas TRAN PR20_avg AVG 1000*(-V(-HV,BQ16)*I(R20))

.meas TRAN PR21_avg AVG 1000*V(VBEM1,BQ19)*I(R21)

.meas TRAN PR22_avg AVG 1000*(-V(VBEM2,BQ20)*I(R22))

.meas TRAN PRVMV_avg AVG 1000*V(BQ19,VBEMRV)*I(RMVM)

.meas TRAN PRMVM_avg AVG 1000*V(VBEMRV,BQ20)*I(RMVM)



.meas TRAN PR31_avg AVG 1000*V(+HVF,CQ31)*I(R31)

.meas TRAN PR32_avg AVG 1000*(-V(-HVF,CQ32)*I(R32))

.meas TRAN PR33_avg AVG 1000*V(RV1M,-RLV)*I(R33)

.meas TRAN PR34_avg AVG 1000*(-V(RV2M,+RLV)*I(R34))

.meas TRAN PR35_avg AVG 1000*V(+HVF,POS_DIFF_OUT)*I(R35)

.meas TRAN PR36_avg AVG 1000*V(-HVF,NEG_DIFF_OUT)*I(R36)

.meas TRAN PR37_avg AVG 1000*V(BQ35)*I(R37)

.meas TRAN PR38_avg AVG 1000*(-V(BQ36)*I(R38))

.meas TRAN PRV1_avg AVG 1000*V(EQ35,RV1M)*I(R33)

.meas TRAN PRV2_avg AVG 1000*(-V(EQ36,RV2M)*I(R34))

.meas TRAN PRIOF_avg AVG 1000*V(din)*I(RIOF)









