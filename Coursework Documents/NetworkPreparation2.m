clc
clear
%%Establishing a network in terms of square dimension N
tic
N = 20
    %Define the number of nodes and their IDs
    NodeCount = N.^2;
    NodeID = linspace(1,NodeCount,NodeCount);
    
    %Aim is to get a node between each point in a manhatten network format
    %Full explination on IPad but nodes can be split into groups, starting at
    %the bottom right and progressing up through each column sequentially, each
    %node sends either one or two edges (except the last which sends zero)
    % This splits them into groupings in terms of N
    topNodeID = linspace(N,NodeCount,N);
    rightNodeID = linspace(NodeCount+1-N,NodeCount,N);
    centralNodeID = setdiff(NodeID,[rightNodeID topNodeID]);
    
    %This uses the groupings with the geometrical relationship to their
    %recipiants and makes the groupings of the recieving nodes
    topConnectionNodeID = topNodeID(1,1:N-1) + N;
    rightConnectionNodeID = rightNodeID(1,1:N-1) + 1;
    horizontal_vertical = [N 1];
    centralConnectionNodeID = [];
    for i=1:(N-1)^2
        centralConnectionNodeID = [centralConnectionNodeID [horizontal_vertical+centralNodeID(1,i)]];
    end
    %These are then married up using graph(). All resistances = 1 aswell
    sending = [sort([centralNodeID centralNodeID]) topNodeID rightNodeID];
    sending(sending==NodeCount) = [];
    recieving = [centralConnectionNodeID topConnectionNodeID rightConnectionNodeID];
    connection_count = length(sending);
    resistances = ones(connection_count,1);
    edge_data = [sending(:) recieving(:)];
    
    %FORMAT:
    %[X,V]=KirchoffSolve(st,r,listAnode,listCnode)
    %st = edge start/end data
    %r = edge weight data
    % listAnode = anode node ID
    % listCnode = cathode node ID
    
    %Collect node and edge data
    [X,V]=KirchoffSolve(edge_data,resistances,1,NodeCount);
    network_resistance = max(V);
    toc
    %X = edge currents
    %V = Node voltages
    %Graph new data where weightings =  current 
    G = graph(sending,recieving,X);
    G.Edges.LWidths = 5*G.Edges.Weight/max(G.Edges.Weight);
    G.Nodes.Voltages = V;
    

    %Build network coordinates to it's plotted square.
    x = [];
    y = [];
    for k = 1:N
       x = [x (zeros(1,N)+k)];
       y = [y 1:N];
    end

p = plot(G)
p = plot(G,'EdgeLabel',G.Edges.Weight,'NodeLabel',G.Nodes.Voltages,'LineStyle','-')

p = plot(G,'XData',x,'YData',y,'LineStyle','-')
p.LineWidth = G.Edges.LWidths;
p.Marker = 'o';
p.NodeColor = 'r';
p.MarkerSize = 6;
p.NodeLabel = [];

%current = 1 therefore network resistance = cathode voltage
max(V)










