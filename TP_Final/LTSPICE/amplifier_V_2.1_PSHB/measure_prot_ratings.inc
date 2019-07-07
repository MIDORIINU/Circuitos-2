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



.meas TRAN IR1_rms RMS I(R1) FROM {datastart}
.meas TRAN IR1_max MAX I(R1)
.meas TRAN PR1_avg AVG I(R1)*V(EQ5, MID_POS) FROM {datastart}

.meas TRAN IR2_rms RMS I(R2) FROM {datastart}
.meas TRAN IR2_max MAX I(R2)
.meas TRAN PR2_avg AVG -I(R2)*V(EQ6, MID_NEG) FROM {datastart}

.meas TRAN IR3_rms RMS I(R3) FROM {datastart}
.meas TRAN IR3_max MAX I(R3)
.meas TRAN PR3_avg AVG I(R3)*V(EQ3, out) FROM {datastart}

.meas TRAN IR4_rms RMS I(R4) FROM {datastart}
.meas TRAN IR4_max MAX I(R4)
.meas TRAN PR4_avg AVG -I(R4)*V(EQ4, out) FROM {datastart}

.meas TRAN IR5_rms RMS I(R5) FROM {datastart}
.meas TRAN IR5_max MAX I(R5)
.meas TRAN PR5_avg AVG I(R5)*V(EQ5, MID_POS) FROM {datastart}

.meas TRAN IR6_rms RMS I(R6) FROM {datastart}
.meas TRAN IR6_max MAX I(R6)
.meas TRAN PR6_avg AVG -I(R6)*V(EQ6, MID_NEG) FROM {datastart}






