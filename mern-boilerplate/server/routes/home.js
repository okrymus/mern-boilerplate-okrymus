'use strict';

const express = require('express');
const home = require('../src/home');
const router = express.Router();

router.get('*', home.index);

module.exports = router;
