* Created by Frederick Brown on 10 March 2010, mod AOINEKO 30 June 2019
.subckt 1P3T 1 2 3 4 5
R12 1 2 { IF ( SET < 2, 1u, 1T) }
R13 1 3 { IF ( SET <= 2 & SET >= 2, 1u, 1T) }
R14 1 4 { IF ( SET <= 3 & SET >= 3, 1u, 1T) }
R15 1 5 { IF ( SET > 3, 1u, 1T) }
.ends 1P3T
