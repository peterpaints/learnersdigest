/* eslint-env browser */

window.onload = () => {
  $('.alert').hide();
  const vis = window.vis;
  const topics = gon.topic_titles.map((title) => {
    return { label: title };
  });

  const nodes = new vis.DataSet(topics);

  const edges = new vis.DataSet();
  const container = document.getElementById('bubbles');
  const data = {
    nodes,
    edges,
  };
  const options = {
    nodes: {
      borderWidth: 0,
      shape: 'circle',
      color: {
        background: '#b55246',
        highlight: {
          background: '#451025',
          border: '#451025',
        },
        hover: {
          background: '#451025',
          border: '#451025',
        },
      },
      size: 100,
      font: {
        color: '#fff',
      },
    },
    physics: {
      stabilization: false,
      minVelocity: 0.01,
      solver: 'repulsion',
      repulsion: {
        nodeDistance: 55,
      },
    },
    interaction: {
      dragView: false,
      zoomView: false,
      hover: true,
    },
  };
  const network = new vis.Network(container, data, options);

  // make previously selected topics distinguishable
  const networkNodes = Object.values(network.body.nodes);
  if (gon.user_topics) {
    networkNodes.forEach(node => {
      if (gon.user_topics.indexOf(node.options.label) != -1) {
        node.options.color.background = '#451025';
      }
    });
  }

  // Events
  network.on('click', (e) => {
    if (e.nodes.length) {
      const node = nodes.get(e.nodes[0]);
      if (!node.color) {
        node.color = {
          background: '#451025',
          highlight: {
            background: '#451025',
            border: '#451025',
          },
        }
      } else {
        if (node.color.background == '#451025') {
          node.color = {
            background: '#b55246',
            highlight: {
              background: '#b55246',
              border: '#b55246',
            },
          }
        } else {
          node.color = {
            background: '#451025',
            highlight: {
              background: '#451025',
              border: '#451025',
            },
          }
        }
      }
      nodes.update(node);
    }
  });

  const done = document.getElementById('done');
  done.addEventListener('click', () => {
    const nodes = Object.values(network.body.nodes);
    const selected_topics = nodes.filter((node) => {
      return node.options.color.background == '#451025'
    }).map((node) => {
      return node.options.label;
    });

    return $.ajax({
      url: "/topics",
      type: "POST",
      data: {selected_topics},
      success: (response) => {
        if (response.success && response.status == 201) {
          window.location.href = '/dashboard';
        }
      },
      error: (error) => {
        if (error.responseJSON) {
          $('<p>' + error.responseJSON.message + '</p>').appendTo('.alert');
          $('.alert').show();
        } else {
          window.location.href = '/dashboard';
        }
      },
    });
  });
};
