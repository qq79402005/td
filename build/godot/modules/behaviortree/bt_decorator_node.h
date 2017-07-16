#ifndef BT_DECORATOR_NODE_H
#define BT_DECORATOR_NODE_H

#include "bt_node.h"
#include "bt_behavior_delegate.h"

class BTDecoratorNode : public BTNode
{
	OBJ_TYPE(BTDecoratorNode, BTNode);

	virtual void add_child_node(BTNode& child, Vector<BehaviorTree::Node*>& node_hierarchy) override;
	virtual void remove_child_node(BTNode& child, Vector<BehaviorTree::Node*>& node_hierarchy) override;
	virtual void move_child_node(BTNode& child, Vector<BehaviorTree::Node*>& node_hierarchy) override;

	struct Delegate : public BehaviorDelegate<BehaviorTree::Decorator>
	{
		typedef BehaviorDelegate<BehaviorTree::Decorator> super;

		Delegate(BTNode& node_):super(node_) {}

		virtual void restore_running(BehaviorTree::VirtualMachine& vm, BehaviorTree::IndexType index, void* context, BehaviorTree::VMRunningData& running_data) override;
		virtual void prepare(BehaviorTree::VirtualMachine& vm, BehaviorTree::IndexType index, void* context, BehaviorTree::VMRunningData& running_data) override;

		virtual BehaviorTree::E_State pre_update(BehaviorTree::IndexType, void*, BehaviorTree::VMRunningData& running_data) override;
		virtual BehaviorTree::E_State post_update(BehaviorTree::IndexType, void*, BehaviorTree::E_State child_state, BehaviorTree::VMRunningData& running_data) override;

		virtual void abort(BehaviorTree::VirtualMachine& , BehaviorTree::IndexType, void* , BehaviorTree::VMRunningData& running_data) override;
	};
	Delegate delegate;

public:
	BTDecoratorNode();

protected:
	BehaviorTree::Node* get_behavior_node() { return &delegate; }

	static void _bind_methods();
};

#endif
