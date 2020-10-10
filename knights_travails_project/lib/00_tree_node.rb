class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil 
        @children = []
    end

    def parent=(other_node=nil)
        parent.children.delete_if { |child| child == self} if !parent.nil?
        @parent = other_node
        if !other_node.nil?
            other_node.children << self if !other_node.children.include?(self)
        end
    end

    def add_child(other_node)
        other_node.parent = self
        self.children << other_node if !self.children.include?(other_node)
    end

    def remove_child(other_node)
        if children.include?(other_node)
            other_node.parent = nil
            # children.delete_if { |child| child == other_node}
        else
            raise "Node is not a child"
        end
    end

    def dfs(target_value)
        return self if self.value == target_value
        children.each do |child|
            result = child.dfs(target_value)
            return result if result != nil 
        end
        nil
    end

    def bfs(target_value)
        arr = [self]
        until arr.empty?
            node = arr.shift
            if node.value == target_value
                return node
            else
                arr += node.children
            end
        end
        nil
    end
end