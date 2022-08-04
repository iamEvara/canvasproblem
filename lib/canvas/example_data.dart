import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/component.dart';

final bankExampleComponent = CanvasComponentData(
  node: {
    "_designCredit": "https://dribbble.com/RikoSapto",
    "type": "theme",
    "args": {
      "data": {
        "backgroundColor": "#2c3ea4",
        "primaryColor": "#2c3ea4",
        "primaryColorBrightness": "dark",
        "scaffoldBackgroundColor": "#2c3ea4"
      }
    },
    "child": {
      "type": "scaffold",
      "args": {
        "appBar": {
          "type": "app_bar",
          "args": {
            "elevation": 0,
            "title": {
              "type": "text",
              "args": {"text": "Bank Example"}
            }
          }
        },
        "body": {
          "type": "single_child_scroll_view",
          "child": {
            "type": "container",
            "args": {
              "alignment": "topCenter",
              "padding": [16, 20],
              "width": "infinity"
            },
            "child": {
              "type": "container",
              "args": {
                "constraints": {"maxWidth": 420}
              },
              "child": {
                "type": "column",
                "args": {"crossAxisAlignment": "center"},
                "children": [
                  {
                    "type": "container",
                    "args": {"height": 100, "margin": 8, "width": 100},
                    "child": {
                      "type": "clip_rrect",
                      "args": {
                        "borderRadius": {"type": "circular", "radius": 50}
                      },
                    }
                  },
                  {
                    "type": "sized_box",
                    "args": {"height": 16.0}
                  },
                  {
                    "type": "text",
                    "args": {
                      "text": "Jane Doe",
                      "style": {"color": "#fff", "fontSize": 18}
                    }
                  },
                  {
                    "type": "sized_box",
                    "args": {"height": 16.0}
                  },
                  {
                    "type": "row",
                    "args": {
                      "crossAxisAlignment": "end",
                      "mainAxisSize": "min"
                    },
                    "children": [
                      {
                        "type": "padding",
                        "args": {
                          "padding": {"bottom": 4}
                        },
                        "child": {
                          "type": "text",
                          "args": {
                            "text": r"$",
                            "style": {"color": "#fff"}
                          }
                        }
                      },
                      {
                        "type": "sized_box",
                        "args": {"width": 4}
                      },
                      {
                        "type": "text",
                        "args": {
                          "text": "28,520",
                          "style": {"color": "#fff", "fontSize": 24}
                        }
                      }
                    ]
                  },
                  {
                    "type": "sized_box",
                    "args": {"height": 24}
                  },
                  {
                    "type": "row",
                    "args": {
                      "crossAxisAlignment": "center",
                      "mainAxisAlignment": "center"
                    },
                    "children": [
                      {
                        "type": "row",
                        "args": {
                          "crossAxisAlignment": "center",
                          "mainAxisSize": "min"
                        },
                        "children": [
                          {
                            "type": "container",
                            "args": {
                              "alignment": "center",
                              "decoration": {
                                "border": {"color": "#6d78b6", "width": 1},
                                "shape": "circle"
                              },
                              "padding": 4
                            },
                            "child": {
                              "type": "icon",
                              "args": {
                                "color": "#fff",
                                "icon": {
                                  "codePoint": "0xe5db",
                                  "fontFamily": "MaterialIcons"
                                }
                              }
                            }
                          },
                          {
                            "type": "sized_box",
                            "args": {"width": 16.0}
                          },
                          {
                            "type": "column",
                            "children": [
                              {
                                "type": "text",
                                "args": {
                                  "text": "Income",
                                  "style": {"color": "#6d78b6", "fontSize": 14}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": r"$ 32,500",
                                  "style": {"color": "#fff", "fontSize": 16}
                                }
                              }
                            ]
                          }
                        ]
                      },
                      {
                        "type": "container",
                        "args": {
                          "alignment": "center",
                          "padding": [32, 0]
                        },
                        "child": {
                          "type": "container",
                          "args": {"color": "#6d78b6", "height": 40, "width": 1}
                        }
                      },
                      {
                        "type": "row",
                        "args": {
                          "crossAxisAlignment": "center",
                          "mainAxisSize": "min"
                        },
                        "children": [
                          {
                            "type": "container",
                            "args": {
                              "alignment": "center",
                              "decoration": {
                                "border": {"color": "#6d78b6", "width": 1},
                                "shape": "circle"
                              },
                              "padding": 4
                            },
                            "child": {
                              "type": "icon",
                              "args": {
                                "color": "#fff",
                                "icon": {
                                  "codePoint": "0xe5d8",
                                  "fontFamily": "MaterialIcons"
                                }
                              }
                            }
                          },
                          {
                            "type": "sized_box",
                            "args": {"width": 16.0}
                          },
                          {
                            "type": "column",
                            "children": [
                              {
                                "type": "text",
                                "args": {
                                  "text": "Spending",
                                  "style": {"color": "#6d78b6", "fontSize": 14}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": r"$ 10,120",
                                  "style": {"color": "#fff", "fontSize": 16}
                                }
                              }
                            ]
                          }
                        ]
                      }
                    ]
                  },
                  {
                    "type": "sized_box",
                    "args": {"height": 24}
                  },
                  {
                    "type": "material",
                    "args": {
                      "borderRadius": {"type": "circular", "radius": 8},
                      "color": "#5871dd"
                    },
                    "child": {
                      "type": "container",
                      "args": {
                        "padding": [60, 30],
                        "width": "infinity"
                      },
                      "child": {
                        "type": "column",
                        "args": {"crossAxisAlignment": "start"},
                        "children": [
                          {
                            "type": "material",
                            "args": {
                              "borderRadius": {"type": "circular", "radius": 4},
                              "color": "#dfe2e9",
                              "elevation": 1
                            },
                            "child": {
                              "type": "container",
                              "args": {"height": 30, "width": 50},
                              "child": {
                                "type": "set_value",
                                "args": {"etchColor": "#b6b9c8"},
                                "child": {
                                  "type": "stack",
                                  "children": [
                                    {
                                      "type": "positioned",
                                      "args": {"left": 0, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"right": 0, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"bottom": 10, "left": 0},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"bottom": 10, "right": 0},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"right": 20, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 10,
                                          "width": 1
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"left": 20, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 10,
                                          "width": 1
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"left": 20, "top": 5},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "decoration": {
                                            "border": {
                                              "color": r"${etchColor}",
                                              "style": "solid",
                                              "width": 1
                                            },
                                            "borderRadius": {
                                              "type": "all",
                                              "radius": 5
                                            }
                                          },
                                          "height": 20,
                                          "width": 10
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"right": 10, "top": 0},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 10,
                                          "width": 1
                                        }
                                      }
                                    }
                                  ]
                                }
                              }
                            }
                          },
                          {
                            "type": "sized_box",
                            "args": {"height": 20}
                          },
                          {
                            "type": "row",
                            "args": {"mainAxisAlignment": "spaceBetween"},
                            "children": [
                              {
                                "type": "text",
                                "args": {
                                  "text": "2802",
                                  "style": {"color": "#e6e9f4"}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": "8492",
                                  "style": {"color": "#e6e9f4"}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": "8201",
                                  "style": {"color": "#e6e9f4"}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": "2748",
                                  "style": {"color": "#e6e9f4"}
                                }
                              }
                            ]
                          },
                          {
                            "type": "sized_box",
                            "args": {"height": 20}
                          },
                          {
                            "type": "row",
                            "children": [
                              {
                                "type": "column",
                                "args": {
                                  "crossAxisAlignment": "start",
                                  "mainAxisSize": "min"
                                },
                                "children": [
                                  {
                                    "type": "text",
                                    "args": {
                                      "text": "EXP 02/21",
                                      "style": {
                                        "color": "#9dabe8",
                                        "fontSize": 10
                                      }
                                    }
                                  },
                                  {
                                    "type": "text",
                                    "args": {
                                      "text": "JANE DOE",
                                      "style": {
                                        "color": "#9dabe8",
                                        "fontSize": 12,
                                        "fontWeight": "bold"
                                      }
                                    }
                                  }
                                ]
                              },
                              {
                                "type": "expanded",
                                "child": {"type": "sized_box"}
                              },
                            ]
                          }
                        ]
                      }
                    }
                  },
                  {
                    "type": "sized_box",
                    "args": {"height": 24}
                  },
                  {
                    "type": "material",
                    "args": {
                      "borderRadius": {"type": "circular", "radius": 8},
                      "color": "#5871dd"
                    },
                    "child": {
                      "type": "container",
                      "args": {
                        "padding": [60, 30],
                        "width": "infinity"
                      },
                      "child": {
                        "type": "column",
                        "args": {"crossAxisAlignment": "start"},
                        "children": [
                          {
                            "type": "material",
                            "args": {
                              "borderRadius": {"type": "circular", "radius": 4},
                              "color": "#dfe2e9",
                              "elevation": 1
                            },
                            "child": {
                              "type": "container",
                              "args": {"height": 30, "width": 50},
                              "child": {
                                "type": "set_value",
                                "args": {"etchColor": "#b6b9c8"},
                                "child": {
                                  "type": "stack",
                                  "children": [
                                    {
                                      "type": "positioned",
                                      "args": {"left": 0, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"right": 0, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"bottom": 10, "left": 0},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"bottom": 10, "right": 0},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 1,
                                          "width": 20
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"right": 20, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 10,
                                          "width": 1
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"left": 20, "top": 10},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 10,
                                          "width": 1
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"left": 20, "top": 5},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "decoration": {
                                            "border": {
                                              "color": r"${etchColor}",
                                              "style": "solid",
                                              "width": 1
                                            },
                                            "borderRadius": {
                                              "type": "all",
                                              "radius": 5
                                            }
                                          },
                                          "height": 20,
                                          "width": 10
                                        }
                                      }
                                    },
                                    {
                                      "type": "positioned",
                                      "args": {"right": 10, "top": 0},
                                      "child": {
                                        "type": "container",
                                        "args": {
                                          "color": r"${etchColor}",
                                          "height": 10,
                                          "width": 1
                                        }
                                      }
                                    }
                                  ]
                                }
                              }
                            }
                          },
                          {
                            "type": "sized_box",
                            "args": {"height": 20}
                          },
                          {
                            "type": "row",
                            "args": {"mainAxisAlignment": "spaceBetween"},
                            "children": [
                              {
                                "type": "text",
                                "args": {
                                  "text": "9023",
                                  "style": {"color": "#e6e9f4"}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": "2378",
                                  "style": {"color": "#e6e9f4"}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": "1512",
                                  "style": {"color": "#e6e9f4"}
                                }
                              },
                              {
                                "type": "text",
                                "args": {
                                  "text": "1998",
                                  "style": {"color": "#e6e9f4"}
                                }
                              }
                            ]
                          },
                          {
                            "type": "sized_box",
                            "args": {"height": 20}
                          },
                          {
                            "type": "row",
                            "children": [
                              {
                                "type": "column",
                                "args": {
                                  "crossAxisAlignment": "start",
                                  "mainAxisSize": "min"
                                },
                                "children": [
                                  {
                                    "type": "text",
                                    "args": {
                                      "text": "EXP 10/23",
                                      "style": {
                                        "color": "#9dabe8",
                                        "fontSize": 10
                                      }
                                    }
                                  },
                                  {
                                    "type": "text",
                                    "args": {
                                      "text": "JANE DOE",
                                      "style": {
                                        "color": "#9dabe8",
                                        "fontSize": 12,
                                        "fontWeight": "bold"
                                      }
                                    }
                                  }
                                ]
                              },
                              {
                                "type": "expanded",
                                "child": {"type": "sized_box"}
                              },
                            ]
                          }
                        ]
                      }
                    }
                  }
                ]
              }
            }
          }
        }
      }
    }
  },
  label: "Frame 1",
  uKey: UniqueKey(),
  id: const Uuid().v4(),
  size: const Size(340, 750),
  gKey: GlobalKey(),
);
