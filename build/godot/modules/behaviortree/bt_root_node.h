#ifndef BT_ROOT_NODE
#define BT_ROOT_NODE

#include "bt_decorator_node.h"

class BTRootNode : public BTDecoratorNode
{
	OBJ_TYPE(BTRootNode, BTDecoratorNode);

	BehaviorTree::BTStructure bt_structure_data;
	BehaviorTree::NodeList bt_node_list;
	BehaviorTree::VirtualMachine vm;
	Vector<BehaviorTree::VMRunningData> running_data_list;

public:
	BTRootNode();

	virtual void add_child_node(BTNode& child, Vector<BehaviorTree::Node*>& node_hierarchy) override;
	virtual void remove_child_node(BTNode& child, Vector<BehaviorTree::Node*>& node_hierarchy) override;
	virtual void move_child_node(BTNode& child, Vector<BehaviorTree::Node*>& node_hierarchy) override;

	int create_running_data();
	void tick(Object* context, int index = 0);
	void step(Object* context, int index = 0);

protected:
	static void _bind_methods();

private:
	void fetch_node_data_list_from_node_hierarchy(
			const Vector<BehaviorTree::Node*>& node_hierarchy,
			Vector<BehaviorTree::IndexType>& node_hierarchy_index) const;

	BehaviorTree::IndexType find_child_index(BehaviorTree::IndexType parent_index, BehaviorTree::Node* child) const;
	BehaviorTree::IndexType find_node_index_from_node_hierarchy(const Vector<BehaviorTree::Node*>& node_hierarchy) const;
};

#endif
