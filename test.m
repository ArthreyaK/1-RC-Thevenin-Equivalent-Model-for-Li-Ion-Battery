t=transpose((0:1:4799));

voltage_obs = pulseData.voltage;


tau=1.5;
cur=zeros(4800,1);
for i=1:4800
    if (t(i)>299 && t(i)<=310)
    cur(i)=5-(5*exp((-t(i)+299)/tau));
    end

    if (t(i)>310 && t(i)<=1190)
        cur(i)=5;
    end

    if (t(i)>1190 && t(i)<=1201)
    cur(i)=5*exp((-t(i)+1190)/tau);
    end


end

%%
slope=zeros(4801,1);
for i=1:4799
    slope(i)=voltage_obs(i+1)-voltage_obs(i);
end

%%
%Voltage detector

td=zeros(4800,1);
ini=0;
fi=0;
c=0;
for i=1:4800
    
    if(slope(i)>0.00075 && slope(i+1)<=slope(i))
        if (c==0)
            ini=i;
            c=1;
        end
        td(i)=t(i);
        fi=i;
    end
end

r0=(voltage_obs(fi)-voltage_obs(ini))/0.005;

%%
%R1 and C1

rel=voltage_obs(fi)+(voltage_obs(end)-voltage_obs(fi))*0.95;
for i=fi:4800
    if(voltage_obs(i)>=rel)
    j=i;
    break
    end
end

r1=((voltage_obs(j)-voltage_obs(fi))/0.005);
c1=(j-fi)/5/r1;





%%
%current pulse


tau=1.5;
cur=zeros(4800,1);
for i=1:4800
    if (t(i)>299 && t(i)<=310)
    cur(i)=(5-(5*exp((-t(i)+299)/tau)))/1000;
    end

    if (t(i)>310 && t(i)<=1190)
        cur(i)=0.005;
    end

    if (t(i)>1190 && t(i)<=1201)
    cur(i)=(5*exp((-t(i)+1190)/tau))/1000;
    end


end


%%
%Improving
%improvised with higher value of h
h=100;
rms=zeros(h,h,h);

r0_mat=(r0/2:r0/(h-1):r0*1.5);
r1_mat=(r1/2:r1/(h-1):r1*1.5);
c1_mat=(c1/2:c1/(h-1):c1*1.5);

%%

%SELF
% Load data file to use for this project
% - these data have the fields: time, current, voltage
% Also load a skeleton ESC model structure
% - has total capacity and OCV relationship

T = 25;                            % Test temperature
deltaT = 1;                        % sampling period for data
Q = 8.6709; % total capacity of cell

tk = pulseData.time;    % testing time
ik = pulseData.current; % testing current
vk = pulseData.voltage; % testing voltage



for a=1:h
    for b=1:h
        for c=1:h

% Simulate cell model using user-modified rcValues
R0 = r0_mat(a)/1000; % convert milliohms to ohms
R = r1_mat(b)/1000; % convert these also
C = c1_mat(c)*1000; % convert kF to F
RCfact = exp(-deltaT./(R.*C));
    
% Simulate the dynamic states of the model
iRk = zeros(length(RCfact),1); % initial resistor currents
vCk = 0*pulseData.voltage; % initialize capacitor voltages
if ~isempty(RCfact)
  for k = 2:length(vCk)
    iRk = diag(RCfact)*iRk + (1-RCfact)*ik(k-1); % update resistor current
    vCk(k) = R'*iRk; % compute capacitor voltage
  end
end

% Simulate SOC state
z0 = SOCfromOCVtemp(pulseData.voltage(1),25,model); 
zk = z0-cumsum([0;ik(1:end-1)])*deltaT/(Q*3600); 

% Compute voltage estimate
vest = OCVfromSOCtemp(zk,25,model) - vCk - ik.*R0;

% Compare against measured voltage, compute RMSE in mV
rmse = 1000*sqrt(mean((vk - vest).^2));

rms(a,b,c)=rmse;

        end
    end
end

%%
%minimum value
min=100;
l=0;
m=0;
n=0;
for a=1:h
    for b=1:h
        for c=1:h

           if(rms(a,b,c)<min)
           
           min=rms(a,b,c);
           l=a;
           m=b;
           n=c;
           
           end

         end
    end
end

 

%%
% Load data file to use for this capstone project
% - these data have the fields: time, current, voltage
% Also load a skeleton ESC model structure
% - has total capacity and OCV relationship

T=25;                          % Test temperature
deltaT = 1;                        % sampling period for data
Q = 8.6709; % total capacity of cell

tk = pulseData.time;    % testing time
ik = pulseData.current; % testing current
vk = pulseData.voltage; % testing voltage



% Simulate cell model using user-modified rcValues
R0 = r0_mat(l)/1000; % convert milliohms to ohms
R = r1_mat(m)/1000; % convert these also
C = c1_mat(n)*1000; % convert kF to F
RCfact = exp(-deltaT./(R.*C));
    
% Simulate the dynamic states of the model
iRk = zeros(length(RCfact),1); % initial resistor currents
vCk = 0*pulseData.voltage; % initialize capacitor voltages
if ~isempty(RCfact)
  for k = 2:length(vCk)
    iRk = diag(RCfact)*iRk + (1-RCfact)*ik(k-1); % update resistor current
    vCk(k) = R'*iRk; % compute capacitor voltage
  end
end

% Simulate SOC state
z0 = SOCfromOCVtemp(pulseData.voltage(1),25,model); 
zk = z0-cumsum([0;ik(1:end-1)])*deltaT/(Q*3600); 

% Compute voltage estimate
vest = OCVfromSOCtemp(zk,25,model) - vCk - ik.*R0;

% Compare against measured voltage, compute RMSE in mV
rmse = 1000*sqrt(mean((vk - vest).^2));

% Plot some results 
subplot(2,1,1); plot(tk/60,vk,tk/60,vest); 
title('Voltage estimation'); grid on
xlabel('Time (min)'); ylabel('Voltage (V))'); 
legend('True measured voltage','Model voltage','location','southeast');

subplot(2,1,2); plot(tk/60,1000*(vk-vest)); 
title('Voltage estimation errors');
xlabel('Time (min)'); ylabel('Voltage error (mV)');
grid on





