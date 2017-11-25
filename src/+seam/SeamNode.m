classdef SeamNode < handle
    properties
        Row
        Column
        %list of parent nodes
        Parent
        Children
        Energy
        %total energy in order to get to this Node
        SeamEnergy
        %if true than Node is the beging of seam path
        IsRoot
    end
    methods
        %constructors
        function sn = SeamNode(row, column, energy, parent)
            sn.Row = row;
            sn.Column = column;
            sn.Energy = energy;
            sn.SeamEnergy = energy;
            sn.IsRoot = true;
            
            %in case Node has parent, not the first node in seam
            if (exist('parent', 'var') && ~isempty(parent))
                sn.Parent = parent;
                sn.SeamEnergy = parent.SeamEnergy + sn.Energy;
                sn.IsRoot = false;
            end    
        end
        
        function coord = get_coords(obj)
            coord = [obj.Row, obj.Column];
        end
    end    
end