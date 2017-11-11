classdef Seam < handle
    properties
        Nodes
    end
    methods
        function sm = Seam(nodes)
            sm.Nodes = nodes;
        end
        
        function temp = get_seam_path(obj)
            temp = cell(1, length(obj.Nodes));
            
            for i = 1:length(obj.Nodes)
                temp{1, i} = obj.Nodes{i}.get_coords();
            end
            out = temp;
        end
    end
end