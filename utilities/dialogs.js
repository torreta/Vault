const NodeComponent = (next) =>
  function (props) {
    const component = next.bind(this);
    return component(props || {});
  };

const clsx = (object) => {
  const classes = [];

  for (const [key, value] of Object.entries(object)) {
    if (!value) {
      continue;
    }
    classes.push(key);
  }

  return classes.join(" ");
};

const decoratorNodeHtml = (callback) => (propTypes) => {
  const { children, className, events = {}, ...props } = propTypes || {};

  const node = callback();

  const aux = new Set(
    [...node.children].map((n) => {
      if (n instanceof Text) {
        return n.data;
      }

      return n;
    })
  );

  const classes = (className && className.split(" ")) || [];

  for (const classN of classes) {
    node.classList.add(classN);
  }

  if (Array.isArray(children)) {
    for (const child of children) {
      if (aux.has(child)) {
        continue;
      }

      aux.add(child);
      node.append(child);
    }
  } else if (children) {
    node.append(children);
    aux.add(children);
  }

  for (const [key, value] of Object.entries(props)) {
    node.setAttribute(key, value);
  }

  for (const [key, fn] of Object.entries(events)) {
    node[key] = fn;
  }

  return node;
};

const memoizeFn = (callback) => {
  const cache = new Map();

  return function (...args) {
    const key = JSON.stringify(args);

    if (cache.has(key)) {
      return cache.get(key);
    }

    const result = callback(...args);
    cache.set(key, result);
    return result;
  };
};

const makeNodeHtml = (name, props = {}) => {
  const memoize = memoizeFn((nameStr) => document.createElement(nameStr));
  const callback = memoizeFn(decoratorNodeHtml(() => memoize(name)));
  return callback({ ...props });
};

const Dialog = NodeComponent(({ children, ...props }) =>
  makeNodeHtml("div", {
    ...props,
    role: "dialog",
    className: "modal fade",
    children: makeNodeHtml("div", {
      className: "modal-dialog",
      children: makeNodeHtml("div", {
        className: "modal-content",
        children,
      }),
    }),
  })
);

const Button = NodeComponent(({ variant, ...props }) => {
  const variants = new Set(["primary", "secondary"]);

  const className = clsx({
    btn: true,
    "btn-default": !variants.has(variant),
    [`btn-${variant}`]: variant && variants.has(variant),
  });

  return makeNodeHtml("button", {
    ...props,
    type: "button",
    className: className,
  });
});

const DialogContent = NodeComponent((props) =>
  makeNodeHtml("div", {
    ...props,
    className: "modal-body",
  })
);

const IconButtonClose = NodeComponent((props) =>
  makeNodeHtml("button", {
    ...props,
    type: "button",
    className: "close",
    children: makeNodeHtml("span", {
      "aria-hidden": "true",
      children: "x",
    }),
  })
);

const DialogHeader = NodeComponent((props) =>
  makeNodeHtml("div", {
    ...props,
    className: "modal-header",
  })
);

const DialogFooter = NodeComponent((props) =>
  makeNodeHtml("div", {
    ...props,
    className: "modal-footer",
  })
);

const Alert = NodeComponent(({ variant = "info", ...props }) => {
  const className = clsx({
    ["alert-danger"]: variant === "danger",
    ["alert-warning"]: variant === "warning",
    ["alert-info"]: variant === "info",
    ["alert-success"]: variant === "success",
    alert: true,
  });

  return makeNodeHtml("div", {
    ...props,
    role: "alert",
    className: className,
  });
});
