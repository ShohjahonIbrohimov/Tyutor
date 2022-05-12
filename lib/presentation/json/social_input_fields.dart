List socialInputFields = [
  {
    'name': 'soc_many_children',
    'type': 'radio',
    'options': [
      {'key': '_yes', 'value': 1},
      {'key': "_no", 'value': 0},
    ]
  },
  {
    'name': "soc_poor_family",
    'type': 'radio',
    'options': [
      {'value': 1, 'key': '_yes'},
      {'value': 0, 'key': "_no"},
    ]
  },
  {
    'name': "soc_incapable_family",
    'type': 'radio',
    'options': [
      {'value': 1, 'key': '_yes'},
      {'value': 0, 'key': "_no"},
    ]
  },
  {
    'name': "soc_pure_orphan",
    'type': 'radio',
    'options': [
      {'value': 0, 'key': 'true_orphan'},
      {'value': 1, 'key': "no_father"},
      {'value': 2, 'key': "no_mother"},
    ]
  },
  {
    'name': "soc_retired_family",
    'type': 'radio',
    'options': [
      {'value': 0, 'key': '_father'},
      {'value': 1, 'key': "_mother"},
      {'value': 2, 'key': "_both"},
    ]
  },
  {
    'name': "soc_invalid_parent",
    'type': 'radio',
    'options': [
      {'value': 0, 'key': '_father'},
      {'value': 1, 'key': "_mother"},
      {'value': 2, 'key': "_both"},
    ]
  },
  {
    'name': "soc_invalid_student",
    'type': 'radio',
    'options': [
      {'value': 0, 'key': "_no"},
      {'value': 1, 'key': "group_1"},
      {'value': 2, 'key': "group_2"},
      {'value': 3, 'key': "group_3"},
      {'value': 4, 'key': "group_4"},
    ]
  },
  {
    'name': "soc_is_works",
    'type': 'radio',
    'options': [
      {'value': 1, 'key': '_yes'},
      {'value': 0, 'key': "_no"},
    ]
  },
];
