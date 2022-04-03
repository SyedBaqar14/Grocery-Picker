class GQLQuries {

  static const String getPendingOrders = """query listOrdersFilters(\$userId:Int,\$orderStatus:Int){
  listOrdersFilters(paramsFilter:{assign_user_id:\$userId,order_status_id:\$orderStatus}){
    orders{
      id
      date_added_format
      delivery_date_format
      order_products_count {
        total_count
      }
    }
    total_count
  }
}""";

  static const String getUsers = """query {
  listUsers {
    id
    username
  }
}""";

  static const String getRequest = """query getRequest(\$assignUserID:Int!){
  listOrdersFilters(paramsFilter: { assign_user_id: \$assignUserID }) {
    orders{
      id
      date_added_format
      delivery_date_format
      order_products_count {
        total_count
      }
      delivery_assign_user {
        id
        username
      }
    }
    total_count
  }
}
""";
}
