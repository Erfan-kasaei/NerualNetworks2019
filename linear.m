data = xlsread("datasetProcessed.xlsx");
rawIN = data(:,1:3); 
IN = normalize(rawIN,'range')';

%NN Initalisation
TARGET = data(:,5:7)';
plotpv(IN,TARGET);
[Z, settings] = mapstd(IN);
net = perceptron('hardlim', 'learnpn');
net = configure(net,Z, TARGET);

hold on
linehandle = plotpc(net.IW{1},net.b{1});
e = 1;
while(sse(e))
    [net,Y,e] = adapt(net,IN,TARGET);
    linehandle = plotpc(net.IW{1},net.b{1},linehandle);
    drawnow;
end
