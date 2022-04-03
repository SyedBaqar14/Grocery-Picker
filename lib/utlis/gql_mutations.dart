class GQLMutation {
  static String generateOTPQuery = r"""mutation generateOTP($source: String!, $source_type: Int!,$user_type:String!) {
  generateOTP(source: $source, source_type: $source_type,user_type:$user_type) {
    id
  }
}""";

  static String verifyOtpQuery = r"""mutation verifyUserOTP($source: String!, $source_type: Int!, $OTP: Int!) {
  verifyUserOTP(source: $source, source_type: $source_type, OTP: $OTP) {
    id
    is_verified_mobile
  }
}""";

  static String getOrder = r"""query getOrder($orderID: Int!) {
  getOrder(id: $orderID) {
    id
    order_products {
      name
      id
      quantity
      product {
        image
      }
    }
  order_products_count {
    total_count
  }
  }
}
""";

  static String updateStatusOfOrder = r"""mutation updateOrderStatus($id : Int!, $orderStatus:Int!){
  updateStatusOfOrder(id: $id, order_status_id: $orderStatus) {
    id
    order_status_id
    order_status {
      id
      name
    }
    order_products {
      name
      id
      quantity
      product {
        image
      }
    }
  }
}
""";

  static const assignOrder = r"""mutation assignOrder($orderID:Int!,$userID:Int!){
  updateUserAssignOfOrder(id: $orderID, assign_user_id: $userID) {
    id
    delivery_assign_user {
      id
      username
    }
  }
}
""";

  static const addOrderPackage = r"""
  mutation addOrderPackage($orderID:Int!, $packageID:Int!, $package:String!,$packageStatusID:Int!, $userID:Int!){
  addOrderPackage(
    data: {
      order_id: $orderID
      package_id: $packageID
      package: $package
      package_status_id: $packageStatusID
      user_id: $userID
    }
  ) {
    order_id
    user_id
    package_id
    package
    package_status_id
  }
}
""";
}
