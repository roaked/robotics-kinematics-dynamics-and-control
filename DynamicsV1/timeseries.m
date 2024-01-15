%After running CLIK:
q_d = timeseries(qvectors.q.signals.values,qvectors.q.time);
dq_d = timeseries(qvectors.qdot.signals.values,qvectors.q.time);
ddq_d = timeseries(qvectors.qdotdot.signals.values,qvectors.q.time);

p_d = qvectors.p_e{1}.Values;