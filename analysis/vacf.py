import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

vel = np.loadtxt('vel.tmp')
vel = vel[:,1]
length = len(vel)
corr = np.correlate(vel,vel,mode='full')
N = np.size(corr)
corr = corr[N/2:]
for i in range(length):
	corr[i] = corr[i]/(length - i)
np.savetxt("vacf.tmp",corr)
