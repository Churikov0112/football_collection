import 'package:asop_lo_app/src/core/framework/data_delivery/graphql/graphql.dart';


final {{name.camelCase()}}Fragment = GqlFragment(
  id: '{{name.pascalCase()}}Fragment',
  innerFragments: [userFragment],
  body: '''
fragment {{name.pascalCase()}}Fragment on {{name.pascalCase()}} {
      accessToken
      user{
        ...${userFragment.id}
      } 
 }
  ''',
);
