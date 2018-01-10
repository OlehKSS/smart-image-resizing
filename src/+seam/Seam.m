classdef Seam < handle
    properties
        Nodes
        Energy = 0
        is8Connected = true
        connectivityCoeff = 1
    end
    methods
        function sm = Seam(nodes)
            sm.Nodes = nodes;
            sm.Energy = nodes{end}.SeamEnergy;
        end
        
        function temp = get_seam_path(obj)
            temp = cell(1, length(obj.Nodes));
            
            for i = 1:length(obj.Nodes)
                temp{1, i} = obj.Nodes{i}.get_coords();
            end
            out = temp;
        end
        
        function out = get_rows(obj)
            %returns coordinates of rows, that seam pixels are in
            out = zeros(1, length(obj.Nodes));
            
            for i = 1:length(obj.Nodes)
                out(i) = obj.Nodes{i}.Row;
            end
        end
        
        function out = get_columns(obj)
            %returns coordinates of columns, that seam pixels are in
            out = zeros(1, length(obj.Nodes));
            
            for i = 1:length(obj.Nodes)
                out(i) = obj.Nodes{i}.Column;
            end
        end
    end
end