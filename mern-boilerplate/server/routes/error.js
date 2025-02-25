'use strict';

const express = require('express');
const error = require('../src/error');
const router = express.Router();

router.get('*', error.handle);

module.exports = router;
