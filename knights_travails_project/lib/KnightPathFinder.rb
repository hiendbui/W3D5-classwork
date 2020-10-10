require_relative '00_tree_node'

class KnightPathFinder
    attr_reader :root_node

    # (x,y)
    # (x+2,y+1)
    # (x+1, y+2)
    # (x-2, y+1)
    # (x+2, y -1)
    # (x-1, y-2)
    # (x-1, y+2)
    # (x+1, y-2)
    # (x-1, y-2)

    def self.valid_moves(pos)
        x, y = pos
        valid_pos = []
        [1,-1,2,-2].each do |n1|
            [1,-1,2,-2].each do |n2|
                valid_pos << [x+n1, y+n2] if n1 != n2 && (n1 + n2 != 0)
            end
        end
        valid_pos.select do |pos|
            (pos[0] >= 0 && pos[1] >= 0) && (pos[0] < 50 && pos[1] < 50)
        end

    end
    
    def initialize(start_pos)
        # @start_pos = start_pos
        @root_node = PolyTreeNode.new(start_pos)
        @considered_pos = [start_pos]
        # self.build_move_tree
    end

    def new_move_pos(pos)
        moves = KnightPathFinder.valid_moves(pos)
        new_moves = []
        moves.each do |move|
            if !@considered_pos.include?(move)
                new_moves << move
                @considered_pos << move 
            end
        end
        new_moves
    end


    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            r_node = queue.shift
            children_pos = new_move_pos(r_node.value)
            children_pos.each do |pos|
                node = PolyTreeNode.new(pos)
                r_node.add_child(node)
                queue << node
            end
        end
    end

    def find_path(end_pos)
        trace_path_back(@root_node.bfs(end_pos))

    end

    def trace_path_back(node)
        new_arr = [node.value]
        current_child = node 
        until current_child.parent == root_node
            new_arr.unshift(current_child.parent.value)
            current_child = current_child.parent
        end
        new_arr.unshift(root_node.value)
    end

  
end







