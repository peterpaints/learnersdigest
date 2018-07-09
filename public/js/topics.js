/* eslint-env browser */

window.onload = () => {
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
        // node.color.background == '#451025' ? node.color.background = '#b55246' : node.color.background = '#451025';
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
      // gon.selected_topics.push(node.label);
      nodes.update(node);
    }
  });
};
